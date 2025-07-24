import SwiftUI

struct PreferencesView: View {
    @EnvironmentObject var preferencesManager: PreferencesManager
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Preferences")
                .font(.title2)
                .fontWeight(.semibold)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 16) {
                Toggle("Launch at Login", isOn: Binding(
                    get: { preferencesManager.isLoginItem },
                    set: { preferencesManager.setLoginItem(enabled: $0) }
                ))
                .toggleStyle(.checkbox)
                
                Text("ClipStruct will automatically start when you log in to your Mac.")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button("Done") {
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(20)
        .frame(width: 400, height: 200)
    }
}
