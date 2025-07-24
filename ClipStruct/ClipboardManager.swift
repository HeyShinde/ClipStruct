import SwiftUI
import AppKit
import KeyboardShortcuts
import UserNotifications
import Foundation

class ClipboardManager: ObservableObject {
    @Published var items: [ClipboardItem] = []
    @Published var lastCopiedItem: ClipboardItem?
    
    private var lastChangeCount: Int = 0
    private var timer: Timer?
    private let maxItems = 100
    
    // Storage paths
    private let appSupportURL: URL
    private let dataFileURL: URL
    
    // Reference to AppDelegate for closing popover
    weak var appDelegate: AppDelegate?
    
    init() {
        // Create Application Support directory path
        let fileManager = FileManager.default
        let appSupportPath = fileManager.urls(for: .applicationSupportDirectory,
                                            in: .userDomainMask).first!
        
        self.appSupportURL = appSupportPath.appendingPathComponent("ClipStruct")
        self.dataFileURL = appSupportURL.appendingPathComponent("clipboard_history.json")
        
        createAppSupportDirectoryIfNeeded()
        loadPersistedItems()
        setupKeyboardShortcuts()
        requestNotificationPermission()
    }
    
    // Create app directory if it doesn't exist
    private func createAppSupportDirectoryIfNeeded() {
        let fileManager = FileManager.default
        
        if !fileManager.fileExists(atPath: appSupportURL.path) {
            do {
                try fileManager.createDirectory(at: appSupportURL,
                                              withIntermediateDirectories: true,
                                              attributes: nil)
                print("✅ Created ClipStruct directory: \(appSupportURL.path)")
            } catch {
                print("❌ Failed to create app directory: \(error)")
            }
        }
    }
    
    // Request notification permission on init
    private func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error)")
            }
        }
    }
    
    func startMonitoring() {
        lastChangeCount = NSPasteboard.general.changeCount
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            self.checkForChanges()
        }
    }
    
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        saveItems() // Save when stopping monitoring
    }
    
    private func setupKeyboardShortcuts() {
        // Setup hotkeys for copying items 1-9
        KeyboardShortcuts.onKeyDown(for: .copyItem1) { [weak self] in
            self?.copyItemAtIndex(0)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem2) { [weak self] in
            self?.copyItemAtIndex(1)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem3) { [weak self] in
            self?.copyItemAtIndex(2)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem4) { [weak self] in
            self?.copyItemAtIndex(3)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem5) { [weak self] in
            self?.copyItemAtIndex(4)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem6) { [weak self] in
            self?.copyItemAtIndex(5)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem7) { [weak self] in
            self?.copyItemAtIndex(6)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem8) { [weak self] in
            self?.copyItemAtIndex(7)
        }
        
        KeyboardShortcuts.onKeyDown(for: .copyItem9) { [weak self] in
            self?.copyItemAtIndex(8)
        }
    }
    
    private func showStatusBarFeedback() {
        guard let appDelegate = self.appDelegate else { return }
        
        let originalImage = appDelegate.statusBarItem.button?.image
        
        // Change to checkmark icon briefly
        let checkmarkImage = NSImage(systemSymbolName: "checkmark.circle.fill", accessibilityDescription: "Copied")
        checkmarkImage?.isTemplate = true
        appDelegate.statusBarItem.button?.image = checkmarkImage
        
        // Restore original icon after 1 second
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            appDelegate.statusBarItem.button?.image = originalImage
        }
    }
    
    private func copyItemAtIndex(_ index: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self,
                  index < self.items.count else { return }
            
            let item = self.items[index]
            self.copyToPasteboard(item.content)
            
            // Set the last copied item for toast notification
            self.lastCopiedItem = item
            
            // Show status bar feedback immediately
            self.showStatusBarFeedback()
            
            // Show notification
            self.showHotkeyNotification(for: index + 1, content: item.preview)
            
            // Auto-close popover with slight delay for feedback
            self.appDelegate?.closePopoverWithDelay(0.5)
        }
    }

    private func showHotkeyNotification(for number: Int, content: String) {
        // Use macOS User Notifications
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "ClipStruct"
        notificationContent.body = "Copied Item \(number): \(content)"
        notificationContent.sound = nil // Silent notification
        
        let request = UNNotificationRequest(
            identifier: "clipboard-copy-\(UUID())",
            content: notificationContent,
            trigger: nil
        )
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Failed to show notification: \(error)")
            }
        }
        
        // Auto-remove notification after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: [request.identifier])
        }
    }
    
    private func checkForChanges() {
        let pasteboard = NSPasteboard.general
        
        if pasteboard.changeCount != lastChangeCount {
            lastChangeCount = pasteboard.changeCount
            
            if let string = pasteboard.string(forType: .string), !string.isEmpty {
                addItem(content: string)
            }
        }
    }
    
    private func addItem(content: String) {
        // Don't add duplicates that are already at the top
        if let firstItem = items.first, firstItem.content == content {
            return
        }
        
        // Remove existing duplicate if it exists
        items.removeAll { $0.content == content }
        
        // Add new item at the beginning
        let newItem = ClipboardItem(content: content)
        items.insert(newItem, at: 0)
        
        // Maintain max items limit
        if items.count > maxItems {
            items = Array(items.prefix(maxItems))
        }
        
        // Save immediately after adding
        saveItems()
    }
    
    func copyToPasteboard(_ content: String) {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(content, forType: .string)
        
        // Update our change count to avoid re-adding this item
        lastChangeCount = pasteboard.changeCount
        
        // Move this item to the top
        if let index = items.firstIndex(where: { $0.content == content }) {
            let item = items.remove(at: index)
            items.insert(item, at: 0)
            saveItems() // Save after reordering
        }
    }
    
    // Enhanced copy method with auto-close
    func copyToPasteboardAndClose(_ content: String) {
        copyToPasteboard(content)
        
        // Set the last copied item for toast notification
        if let item = items.first(where: { $0.content == content }) {
            lastCopiedItem = item
        }
        
        // Show status bar feedback
        showStatusBarFeedback()
        
        // Auto-close popover after feedback
        appDelegate?.closePopoverWithDelay(1.0)
    }
    
    func removeItem(_ item: ClipboardItem) {
        items.removeAll { $0.id == item.id }
        saveItems()
    }
    
    func clearAll() {
        items.removeAll()
        saveItems()
    }
    
    // MARK: - JSON File Persistence
    
    private func saveItems() {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .iso8601
        encoder.outputFormatting = .prettyPrinted
        
        do {
            let data = try encoder.encode(items)
            try data.write(to: dataFileURL)
            print("💾 Saved \(items.count) items to Application Support")
        } catch {
            print("❌ Failed to save clipboard items: \(error)")
        }
    }
    
    private func loadPersistedItems() {
        guard FileManager.default.fileExists(atPath: dataFileURL.path) else {
            print("📂 No existing data file found, starting fresh")
            return
        }
        
        do {
            let data = try Data(contentsOf: dataFileURL)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            items = try decoder.decode([ClipboardItem].self, from: data)
            print("📁 Loaded \(items.count) items from Application Support")
        } catch {
            print("❌ Failed to load clipboard items: \(error)")
            items = []
        }
    }
    
    // MARK: - Debug and Info Methods
    
    func printStorageInfo() {
        print("\n=== 📊 ClipStruct Storage Information ===")
        print("App Support Directory: \(appSupportURL.path)")
        print("Data File: \(dataFileURL.path)")
        print("File exists: \(FileManager.default.fileExists(atPath: dataFileURL.path))")
        
        if let attributes = try? FileManager.default.attributesOfItem(atPath: dataFileURL.path) {
            let fileSize = attributes[.size] as? Int64 ?? 0
            let formatter = ByteCountFormatter()
            formatter.allowedUnits = [.useBytes, .useKB, .useMB]
            formatter.countStyle = .file
            
            print("File size: \(formatter.string(fromByteCount: fileSize))")
            print("Modified: \(attributes[.modificationDate] as? Date ?? Date())")
        }
        
        print("Current items count: \(items.count)")
        print("Max items limit: \(maxItems)")
        print("=========================================\n")
    }
    
    // Method to open data directory in Finder (useful for debugging)
    func revealDataFolder() {
        NSWorkspace.shared.selectFile(dataFileURL.path, inFileViewerRootedAtPath: appSupportURL.path)
    }
    
    // Method to backup data file
    func createBackup() -> Bool {
        guard FileManager.default.fileExists(atPath: dataFileURL.path) else {
            print("❌ No data file to backup")
            return false
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd_HH-mm-ss"
        let timestamp = dateFormatter.string(from: Date())
        
        let backupURL = appSupportURL.appendingPathComponent("clipboard_history_backup_\(timestamp).json")
        
        do {
            try FileManager.default.copyItem(at: dataFileURL, to: backupURL)
            print("✅ Created backup: \(backupURL.lastPathComponent)")
            return true
        } catch {
            print("❌ Failed to create backup: \(error)")
            return false
        }
    }
}

// Keep your existing ClipboardItem struct unchanged
struct ClipboardItem: Identifiable, Equatable, Codable {
    var id = UUID()
    let content: String
    var timestamp: Date
    
    init(content: String) {
        self.id = UUID()
        self.content = content
        self.timestamp = Date()
    }
    
    var preview: String {
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count > 100 {
            return String(trimmed.prefix(97)) + "..."
        }
        return trimmed
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    var characterCount: Int {
        return content.count
    }
    
    var lineCount: Int {
        return content.components(separatedBy: .newlines).count
    }
    
    var isLongContent: Bool {
        return content.count > 100 || lineCount > 3
    }
    
    var contentStats: String {
        if isLongContent {
            if lineCount > 1 {
                return "\(characterCount) chars, \(lineCount) lines"
            } else {
                return "\(characterCount) chars"
            }
        }
        return ""
    }
}
