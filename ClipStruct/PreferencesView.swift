import SwiftUI

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
            }
            .padding(20)
        }
        .frame(width: 360)
    }
}
