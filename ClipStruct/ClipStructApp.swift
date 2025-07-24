import SwiftUI
import AppKit
import KeyboardShortcuts

@main
struct ClipStructApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var clipboardManager = ClipboardManager()
    @StateObject private var preferencesManager = PreferencesManager()
    
    var body: some Scene {
        Settings {
            EmptyView()
        }
    }
}

class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!
    var popover: NSPopover!
    var clipboardManager: ClipboardManager!
    var preferencesManager: PreferencesManager!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Hide dock icon to make it a menu bar only app
        NSApp.setActivationPolicy(.accessory)
        
        // Initialize managers
        clipboardManager = ClipboardManager()
        preferencesManager = PreferencesManager()
        
        // Set delegate reference for auto-closing popover
        clipboardManager.appDelegate = self
        
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
        clipboardManager.startMonitoring()
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Stop monitoring and save data before quitting
        clipboardManager.stopMonitoring()
    }
    
    private func setupGlobalToggle() {
        KeyboardShortcuts.onKeyDown(for: .toggleClipboard) { [weak self] in
            DispatchQueue.main.async {
                self?.togglePopover()
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
            rootView: ContentView()
                .environmentObject(clipboardManager)
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
}

// MARK: - Notification Extensions (Must be at file scope)
extension Notification.Name {
    static let popoverDidOpen = Notification.Name("popoverDidOpen")
}
