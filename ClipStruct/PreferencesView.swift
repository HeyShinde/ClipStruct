import SwiftUI
import KeyboardShortcuts

struct PreferencesView: View {
    @EnvironmentObject var preferencesManager: PreferencesManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Preferences")
                    .font(.headline)
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(.secondary)
                        .frame(width: 22, height: 22)
                        .background(Color.secondary.opacity(0.1))
                        .clipShape(Circle())
                }
                .buttonStyle(.plain)
                .keyboardShortcut(.escape, modifiers: [])
            }
            .padding()
            
            Divider()
            
            // Content
            VStack(alignment: .leading, spacing: 20) {
                // Global Toggle Shortcut
                VStack(alignment: .leading, spacing: 6) {
                    HStack {
                        Text("Toggle Palette Shortcut")
                            .font(.body)
                        Spacer()
                        KeyboardShortcuts.Recorder(for: .toggleClipboard)
                    }
                    
                    Text("Global keyboard shortcut to open or close the ClipStruct palette from any app.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Divider()

                // Launch at Login
                VStack(alignment: .leading, spacing: 6) {
                    Toggle("Launch at Login", isOn: Binding(
                        get: { preferencesManager.isLoginItem },
                        set: { preferencesManager.setLoginItem(enabled: $0) }
                    ))
                    .toggleStyle(.checkbox)
                    
                    Text("ClipStruct will automatically start when you log in to your Mac.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Divider()
                
                // Ignore Passwords
                VStack(alignment: .leading, spacing: 6) {
                    Toggle("Ignore Passwords (1Password, etc.)", isOn: $preferencesManager.ignorePasswords)
                    .toggleStyle(.checkbox)
                    
                    Text("Automatically ignores sensitive content copied from supported password managers.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
                
                Divider()
                
                // Global Shortcuts
                VStack(alignment: .leading, spacing: 6) {
                    Toggle("Enable Global Shortcuts (Cmd+1 to Cmd+9)", isOn: $preferencesManager.enableGlobalShortcuts)
                    .toggleStyle(.checkbox)
                    
                    Text("Allows pasting from clipboard history while the app is in the background. Note: This overrides default app shortcuts.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }
            .padding(20)
        }
        .frame(width: 360)
    }
}
