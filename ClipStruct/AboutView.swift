import SwiftUI

struct AboutView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20) {
            // App icon (you can replace with your custom icon)
            if let appIcon = NSImage(named: "menuIcon") {
                Image(nsImage: appIcon)
                    .resizable()
                    .frame(width: 64, height: 64)
                    .foregroundColor(.accentColor)
            } else {
                Image(systemName: "doc.on.clipboard")
                    .font(.system(size: 64))
                    .foregroundColor(.accentColor)
            }
            
            VStack(spacing: 8) {
                Text("ClipStruct")
                    .font(.title)
                    .fontWeight(.semibold)
                
                Text("Version \(appVersion)")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Text("A powerful clipboard manager for macOS")
                    .font(.body)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            
            // GitHub Sponsors Section
            VStack(spacing: 12) {
                Text("Support Development")
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Button(action: {
                    openGitHubSponsors()
                }) {
                    HStack(spacing: 8) {
                        Image(systemName: "heart.fill")
                            .foregroundColor(.pink)
                        
                        Text("Sponsor on GitHub")
                            .fontWeight(.medium)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 8)
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(.regularMaterial)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.pink.opacity(0.3), lineWidth: 1)
                            )
                    )
                }
                .buttonStyle(.plain)
                .help("Support ClipStruct development on GitHub Sponsors")
                
                Text("Help keep ClipStruct free and maintained")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .multilineTextAlignment(.center)
            }
            .padding(.top, 8)
            
            Spacer()
            
            HStack(spacing: 16) {
                // Additional links
                Button("GitHub") {
                    openURL("https://github.com/HeyShinde/ClipStruct")
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.blue)
                
                Button("Report Issue") {
                    openURL("https://github.com/HeyShinde/ClipStruct/issues")
                }
                .buttonStyle(.borderless)
                .foregroundStyle(.blue)
                
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding(30)
        .frame(width: 400, height: 450)
    }
    
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    private func openGitHubSponsors() {
        openURL("https://github.com/sponsors/HeyShinde")
    }
    
    private func openURL(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        NSWorkspace.shared.open(url)
    }
}

#Preview {
    AboutView()
}
