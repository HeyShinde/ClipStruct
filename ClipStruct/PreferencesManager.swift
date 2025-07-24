import SwiftUI
import ServiceManagement

class PreferencesManager: ObservableObject {
    @Published var isLoginItem: Bool = false
    
    init() {
        checkLoginItemStatus()
    }
    
    func checkLoginItemStatus() {
        // For macOS 13+
        if #available(macOS 13.0, *) {
            isLoginItem = SMAppService.mainApp.status == .enabled
        } else {
            // For older macOS versions, default to false
            // Users can manually add the app to login items through System Preferences
            isLoginItem = false
        }
    }
    
    func setLoginItem(enabled: Bool) {
        if #available(macOS 13.0, *) {
            do {
                if enabled {
                    try SMAppService.mainApp.register()
                } else {
                    try SMAppService.mainApp.unregister()
                }
                isLoginItem = enabled
            } catch {
                print("Failed to \(enabled ? "enable" : "disable") login item: \(error)")
                
                // Show alert to user for manual setup on older systems
                DispatchQueue.main.async {
                    let alert = NSAlert()
                    alert.messageText = "Login Item Setup"
                    alert.informativeText = enabled ?
                        "Please manually add ClipStruct to your login items in System Preferences > Users & Groups > Login Items." :
                        "Please manually remove ClipStruct from your login items in System Preferences > Users & Groups > Login Items."
                    alert.addButton(withTitle: "OK")
                    alert.runModal()
                }
            }
        } else {
            // For older macOS versions, show instructions
            let alert = NSAlert()
            alert.messageText = "Manual Setup Required"
            alert.informativeText = enabled ?
                "Please manually add ClipStruct to your login items:\n1. Open System Preferences\n2. Go to Users & Groups\n3. Click Login Items\n4. Click + and select ClipStruct" :
                "Please manually remove ClipStruct from your login items in System Preferences > Users & Groups > Login Items."
            alert.addButton(withTitle: "OK")
            alert.runModal()
        }
    }
}
