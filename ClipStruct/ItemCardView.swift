import SwiftUI

struct ItemCardView: View {
    let item: ClipboardItem
    let onCopy: () -> Void
    
    @Environment(\.colorScheme) var colorScheme
    @State private var isHovered = false
    
    var body: some View {
        Button(action: onCopy) {
            VStack(spacing: 0) {
                // Header (Source App & Time)
                HStack {
                    if let bundleID = item.sourceAppBundleID, let icon = getAppIcon(for: bundleID) {
                        Image(nsImage: icon)
                            .resizable()
                            .frame(width: 14, height: 14)
                    }
                    
                    Text(item.sourceAppName ?? "Unknown App")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Text(item.timeAgo)
                        .font(.system(size: 10))
                        .foregroundColor(.secondary.opacity(0.8))
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.secondary.opacity(0.05))
                
                // Content Body
                Group {
                    switch item.category {
                    case .image:
                        if let imagePath = item.thumbnailPath ?? item.imagePath, let nsImage = NSImage(contentsOfFile: getImagesDirectory().appendingPathComponent(imagePath).path) {
                            Image(nsImage: nsImage)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: .infinity, maxHeight: 120)
                                .clipped()
                        } else {
                            Text("Image not found")
                                .foregroundColor(.red)
                                .padding()
                        }
                    case .color:
                        if let hex = item.hexColorString, let color = Color(hex: hex) {
                            HStack {
                                Circle()
                                    .fill(color)
                                    .frame(width: 24, height: 24)
                                    .overlay(Circle().stroke(Color.primary.opacity(0.1), lineWidth: 1))
                                
                                Text(hex)
                                    .font(.system(size: 13, weight: .semibold, design: .monospaced))
                                
                                Spacer()
                            }
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(color.opacity(0.1))
                        }
                    case .link:
                        HStack(spacing: 8) {
                            Image(systemName: "link.circle.fill")
                                .foregroundColor(.blue)
                                .font(.system(size: 20))
                            
                            Text(item.previewText)
                                .font(.system(size: 12))
                                .foregroundColor(.blue)
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                            
                            Spacer()
                        }
                        .padding()
                        
                    case .text, .all:
                        Text(item.previewText)
                            .font(.system(size: 13))
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .topLeading)
                            .padding()
                    }
                }
            }
            .contentShape(Rectangle())
            .background(Color(NSColor.controlBackgroundColor))
            .cornerRadius(12)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isHovered ? Color.blue.opacity(0.5) : Color.primary.opacity(0.1), lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(isHovered ? 0.1 : 0.05), radius: isHovered ? 4 : 2, x: 0, y: isHovered ? 2 : 1)
            .scaleEffect(isHovered ? 1.01 : 1.0)
            .animation(.spring(response: 0.2, dampingFraction: 0.7), value: isHovered)
        }
        .buttonStyle(.plain)
        .onHover { hovering in
            isHovered = hovering
            if hovering {
                NSCursor.pointingHand.push()
            } else {
                NSCursor.pop()
            }
        }
    }
    
    private func getAppIcon(for bundleID: String) -> NSImage? {
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: bundleID) {
            return NSWorkspace.shared.icon(forFile: url.path)
        }
        return nil
    }
    
    private func getImagesDirectory() -> URL {
        let appSupport = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        let appDirectory = appSupport.appendingPathComponent("ClipStruct")
        return appDirectory.appendingPathComponent("Images")
    }
}

// Ensure the hex init compiles
extension Color {
    init?(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0
        guard Scanner(string: hexSanitized).scanHexInt64(&rgb) else { return nil }

        let r, g, b: Double
        if hexSanitized.count == 6 {
            r = Double((rgb & 0xFF0000) >> 16) / 255.0
            g = Double((rgb & 0x00FF00) >> 8) / 255.0
            b = Double(rgb & 0x0000FF) / 255.0
        } else if hexSanitized.count == 3 {
            r = Double((rgb & 0xF00) >> 8) / 15.0
            g = Double((rgb & 0x0F0) >> 4) / 15.0
            b = Double(rgb & 0x00F) / 15.0
        } else {
            return nil
        }
        self.init(red: r, green: g, blue: b)
    }
}
