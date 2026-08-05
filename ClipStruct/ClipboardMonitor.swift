import SwiftUI
import Combine
import AppKit

class ClipboardMonitor: ObservableObject {
    @Published var items: [ClipboardItem] = []
    @Published var isPaused: Bool = false
    
    private var timer: Timer?
    private var lastChangeCount: Int = 0
    private let maxItems = 500
    private let appSupportURL: URL
    private let dataFileURL: URL
    
    // Dependencies
    private let preferencesManager: PreferencesManager
    
    // Popover closing helper
    var onPopoverCloseRequest: (() -> Void)?
    
    init(preferencesManager: PreferencesManager) {
        self.preferencesManager = preferencesManager
        
        let fileManager = FileManager.default
        let appSupportPath = fileManager.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
        self.appSupportURL = appSupportPath.appendingPathComponent("ClipStruct")
        self.dataFileURL = appSupportURL.appendingPathComponent("clipboard_history.json")
        
        createAppSupportDirectoryIfNeeded()
        loadPersistedItems()
    }
    
    // MARK: - Core Engine
    
    func startMonitoring() {
        lastChangeCount = NSPasteboard.general.changeCount
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.checkForChanges()
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        saveItems()
    }
    
    func togglePause() {
        isPaused.toggle()
    }
    
    private func checkForChanges() {
        let pasteboard = NSPasteboard.general
        
        if pasteboard.changeCount != lastChangeCount {
            lastChangeCount = pasteboard.changeCount
            
            if isPaused { return }
            
            let activeApp = NSWorkspace.shared.frontmostApplication
            let appBundleID = activeApp?.bundleIdentifier
            let appName = activeApp?.localizedName
            
            // Password Manager & Sensitive Content Filtering
            if preferencesManager.ignorePasswords {
                let types = pasteboard.types?.map { $0.rawValue } ?? []
                if types.contains("org.nspasteboard.ConcealedType") || types.contains("com.agilebits.onepassword") {
                    return
                }
                
                if let bundle = appBundleID?.lowercased() {
                    let blacklisted = ["proton", "pass", "bitwarden", "keepass", "macpass", "1password"]
                    if blacklisted.contains(where: bundle.contains) {
                        return
                    }
                }
            }
            
            // Handle Images directly on Pasteboard
            if let image = NSImage(pasteboard: pasteboard) {
                if let savedData = saveImageWithThumbnail(image) {
                    processNewItem(content: "[Image]", imagePath: savedData.original, thumbnailPath: savedData.thumbnail, sourceBundleID: appBundleID, sourceName: appName)
                }
            }
            // Handle Files (Copying image files in Finder)
            else if let fileURLs = pasteboard.readObjects(forClasses: [NSURL.self], options: [.urlReadingFileURLsOnly: true]) as? [URL], let firstURL = fileURLs.first {
                let ext = firstURL.pathExtension.lowercased()
                if ["png", "jpg", "jpeg", "gif", "tiff", "heic"].contains(ext) {
                    if let image = NSImage(contentsOf: firstURL), let savedData = saveImageWithThumbnail(image) {
                        processNewItem(content: "[Image]", imagePath: savedData.original, thumbnailPath: savedData.thumbnail, sourceBundleID: appBundleID, sourceName: appName)
                    } else {
                        processNewItem(content: firstURL.lastPathComponent, sourceBundleID: appBundleID, sourceName: appName)
                    }
                } else {
                    processNewItem(content: firstURL.lastPathComponent, sourceBundleID: appBundleID, sourceName: appName)
                }
            }
            // Fallback to text
            else if let string = pasteboard.string(forType: .string), !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // Truncate massively large strings to prevent crashes (e.g. 100k characters)
                let maxLen = 100000
                let finalString = string.count > maxLen ? String(string.prefix(maxLen)) + "... [Truncated]" : string
                processNewItem(content: finalString, sourceBundleID: appBundleID, sourceName: appName)
            }
        }
    }
    
    // MARK: - Item Management
    
    private func processNewItem(content: String, imagePath: String? = nil, thumbnailPath: String? = nil, sourceBundleID: String? = nil, sourceName: String? = nil) {
        // Smart Deduplication: If identical item exists, remove it so it can be moved to the top
        if let existingIndex = items.firstIndex(where: { $0.content == content && $0.imagePath == imagePath }) {
            items.remove(at: existingIndex)
        }
        
        let newItem = ClipboardItem(content: content, imagePath: imagePath, thumbnailPath: thumbnailPath, sourceBundleID: sourceBundleID, sourceName: sourceName)
        
        items.insert(newItem, at: 0)
        
        if items.count > maxItems {
            // Delete old image files if they exist
            let itemsToRemove = items[maxItems...]
            for item in itemsToRemove {
                if let path = item.imagePath {
                    deleteImage(at: path)
                }
                if let thumb = item.thumbnailPath {
                    deleteImage(at: thumb)
                }
            }
            items = Array(items.prefix(maxItems))
        }
        
        saveItems()
    }
    
    func clearAll() {
        for item in items {
            if let path = item.imagePath {
                deleteImage(at: path)
            }
            if let thumb = item.thumbnailPath {
                deleteImage(at: thumb)
            }
        }
        items.removeAll()
        saveItems()
    }
    
    func delete(at offsets: IndexSet) {
        for index in offsets {
            let item = items[index]
            if let path = item.imagePath {
                deleteImage(at: path)
            }
            if let thumb = item.thumbnailPath {
                deleteImage(at: thumb)
            }
        }
        items.remove(atOffsets: offsets)
        saveItems()
    }
    
    func copyItem(_ item: ClipboardItem) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        
        if let imagePath = item.imagePath {
            let fullURL = getImagesDirectory().appendingPathComponent(imagePath)
            if let image = NSImage(contentsOf: fullURL) {
                pasteboard.writeObjects([image])
            } else {
                pasteboard.setString("Image not found", forType: .string)
            }
        } else {
            pasteboard.setString(item.content, forType: .string)
        }
        
        // Temporarily pause monitoring so we don't pick up our own copy action
        let wasPaused = isPaused
        isPaused = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // Update change count so we ignore it
            self.lastChangeCount = pasteboard.changeCount
            self.isPaused = wasPaused
            
            // Re-order to top
            if let idx = self.items.firstIndex(where: { $0.id == item.id }) {
                let copiedItem = self.items.remove(at: idx)
                self.items.insert(copiedItem, at: 0)
                self.saveItems()
            }
            
            self.showStatusBarFeedback()
            self.onPopoverCloseRequest?()
        }
    }
    
    // MARK: - File I/O
    
    private func createAppSupportDirectoryIfNeeded() {
        if !FileManager.default.fileExists(atPath: appSupportURL.path) {
            try? FileManager.default.createDirectory(at: appSupportURL, withIntermediateDirectories: true)
        }
        let imagesURL = getImagesDirectory()
        if !FileManager.default.fileExists(atPath: imagesURL.path) {
            try? FileManager.default.createDirectory(at: imagesURL, withIntermediateDirectories: true)
        }
    }
    
    func getImagesDirectory() -> URL {
        return appSupportURL.appendingPathComponent("Images")
    }
    
    private func saveImageWithThumbnail(_ image: NSImage) -> (original: String, thumbnail: String)? {
        guard let tiffData = image.tiffRepresentation,
              let bitmapImage = NSBitmapImageRep(data: tiffData),
              let originalPngData = bitmapImage.representation(using: .png, properties: [:]) else {
            return nil
        }
        
        let uuid = UUID().uuidString
        let originalFilename = "\(uuid).png"
        let thumbnailFilename = "\(uuid)_thumb.png"
        
        let originalURL = getImagesDirectory().appendingPathComponent(originalFilename)
        let thumbnailURL = getImagesDirectory().appendingPathComponent(thumbnailFilename)
        
        // Generate Thumbnail (max height 150)
        let ratio = image.size.width / image.size.height
        let thumbHeight: CGFloat = 150
        let thumbWidth = thumbHeight * ratio
        let thumbSize = NSSize(width: thumbWidth, height: thumbHeight)
        
        let thumbImage = NSImage(size: thumbSize)
        thumbImage.lockFocus()
        image.draw(in: NSRect(origin: .zero, size: thumbSize))
        thumbImage.unlockFocus()
        
        var thumbPngData = originalPngData // fallback
        if let thumbTiff = thumbImage.tiffRepresentation,
           let thumbBitmap = NSBitmapImageRep(data: thumbTiff),
           let resizedPng = thumbBitmap.representation(using: .png, properties: [:]) {
            thumbPngData = resizedPng
        }
        
        do {
            try originalPngData.write(to: originalURL)
            try thumbPngData.write(to: thumbnailURL)
            return (originalFilename, thumbnailFilename)
        } catch {
            print("Failed to save image: \(error)")
            return nil
        }
    }
    
    private func deleteImage(at filename: String) {
        let fileURL = getImagesDirectory().appendingPathComponent(filename)
        try? FileManager.default.removeItem(at: fileURL)
    }
    
    private func loadPersistedItems() {
        DispatchQueue.global(qos: .userInitiated).async {
            guard let data = try? Data(contentsOf: self.dataFileURL) else { return }
            let decoder = JSONDecoder()
            if let decodedItems = try? decoder.decode([ClipboardItem].self, from: data) {
                DispatchQueue.main.async {
                    self.items = decodedItems
                }
            }
        }
    }
    
    private func saveItems() {
        let itemsToSave = self.items
        DispatchQueue.global(qos: .background).async {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(itemsToSave) {
                try? encoded.write(to: self.dataFileURL)
            }
        }
    }
    
    // MARK: - Status Bar Feedback
    
    private func showStatusBarFeedback() {
        if let appDelegate = NSApp.delegate as? AppDelegate,
           let button = appDelegate.statusBarItem?.button {
            button.image = NSImage(systemSymbolName: "checkmark.circle.fill", accessibilityDescription: "Copied")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                if let customIcon = NSImage(named: "menuIcon") {
                    customIcon.size = NSSize(width: 18, height: 18)
                    customIcon.isTemplate = true
                    button.image = customIcon
                } else {
                    button.image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "Clipboard")
                }
            }
        }
    }
}
