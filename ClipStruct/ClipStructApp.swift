import SwiftUI
import AppKit
import KeyboardShortcuts

@main
struct ClipStructApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    var clipboardMonitor: ClipboardMonitor!
    var preferencesManager: PreferencesManager!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Hide dock icon to make it a menu bar only app
        NSApp.setActivationPolicy(.accessory)
        
        // Initialize managers
        preferencesManager = PreferencesManager()
        clipboardMonitor = ClipboardMonitor(preferencesManager: preferencesManager)
        
        // Set delegate references
        clipboardMonitor.onPopoverCloseRequest = { [weak self] in
            self?.closePopoverWithDelay(0.5)
        }
        clipboardMonitor.onShowFeedback = { [weak self] in
            DispatchQueue.main.async {
                self?.showStatusBarFeedback()
            }
        }
        
        // Setup status bar
        setupStatusBar()
        
        // Setup popover
        setupPopover()
        
        // Setup global toggle hotkey
        setupGlobalToggle()
        
        // Set as login item if first launch
        if !UserDefaults.standard.bool(forKey: "hasLaunchedBefore") {
            preferencesManager.setLoginItem(enabled: true)
            UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
        }
        
        // Start clipboard monitoring
        clipboardMonitor.startMonitoring()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Stop monitoring and save data before quitting
        clipboardMonitor.stopMonitoring()
    }
    
    private func setupGlobalToggle() {
        KeyboardShortcuts.onKeyDown(for: .toggleClipboard) { [weak self] in
            DispatchQueue.main.async {
                self?.togglePopover()
            }
        }
        
        let shortcuts: [KeyboardShortcuts.Name] = [
            .copyItem1, .copyItem2, .copyItem3, .copyItem4, .copyItem5,
            .copyItem6, .copyItem7, .copyItem8, .copyItem9
        ]
        
        for (index, shortcut) in shortcuts.enumerated() {
            KeyboardShortcuts.onKeyDown(for: shortcut) { [weak self] in
                DispatchQueue.main.async {
                    guard let self = self,
                          let monitor = self.clipboardMonitor,
                          self.preferencesManager.enableGlobalShortcuts else { return }
                    
                    // Get filtered/sorted items conceptually, but since background we just use the raw items
                    // Wait, we should sort by pinned first, then timestamp to match the UI!
                    let sortedItems = monitor.items.sorted {
                        if $0.isPinned == $1.isPinned {
                            return $0.timestamp > $1.timestamp
                        }
                        return $0.isPinned && !$1.isPinned
                    }
                    
                    if index < sortedItems.count {
                        monitor.copyItem(sortedItems[index])
                    }
                }
            }
        }
    }
    
    func setupStatusBar() {
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
        
        if let button = statusBarItem.button {
            // Try to load custom icon, fallback to system icon
            if let customIcon = NSImage(named: "menuIcon") {
                customIcon.size = NSSize(width: 18, height: 18)
                customIcon.isTemplate = true
                button.image = customIcon
            } else {
                button.image = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "Clipboard")
            }
            
            button.action = #selector(togglePopover)
            button.target = self
        }
    }
    
    func setupPopover() {
        popover = NSPopover()
        popover.contentSize = NSSize(width: 350, height: 500)
        popover.behavior = .transient
        popover.contentViewController = NSHostingController(
            rootView: MainView()
                .environmentObject(clipboardMonitor)
                .environmentObject(preferencesManager)
        )
    }
    
    @objc func togglePopover() {
        if let button = statusBarItem.button {
            if popover.isShown {
                popover.performClose(nil)
            } else {
                // Activate the app to ensure the popover appears in front
                NSApp.activate(ignoringOtherApps: true)
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
                
                // Notify that popover opened (for search focus)
                NotificationCenter.default.post(name: .popoverDidOpen, object: nil)
            }
        }
    }
    
    // MARK: - Auto-Close Methods
    
    func closePopover() {
        if popover.isShown {
            popover.performClose(nil)
        }
    }
    
    func closePopoverWithDelay(_ delay: TimeInterval = 0.3) {
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) { [weak self] in
            self?.closePopover()
        }
    }
    
    // MARK: - Status Bar Feedback
    
    func showStatusBarFeedback() {
        guard let button = statusBarItem?.button else { return }
        
        if let checkmarkImage = NSImage(systemSymbolName: "checkmark.circle.fill", accessibilityDescription: "Copied") {
            checkmarkImage.isTemplate = true
            button.image = checkmarkImage
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) { [weak self] in
            guard let self = self, let button = self.statusBarItem?.button else { return }
            if let customIcon = NSImage(named: "menuIcon") {
                customIcon.size = NSSize(width: 18, height: 18)
                customIcon.isTemplate = true
                button.image = customIcon
            } else {
                if let fallback = NSImage(systemSymbolName: "doc.on.clipboard", accessibilityDescription: "Clipboard") {
                    fallback.isTemplate = true
                    button.image = fallback
                }
            }
        }
    }
}

// MARK: - Notification Extensions (Must be at file scope)
extension Notification.Name {
    static let popoverDidOpen = Notification.Name("popoverDidOpen")
}
