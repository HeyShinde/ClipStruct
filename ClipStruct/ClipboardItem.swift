import Foundation
import SwiftUI

struct ClipboardItem: Identifiable, Codable {
    var id: UUID = UUID()
    var content: String
    var timestamp: Date = Date()
    var imagePath: String?
    var thumbnailPath: String?
    
    // Metadata
    var sourceAppBundleID: String?
    var sourceAppName: String?
    
    // Pre-computed category to save CPU cycles
    var category: ItemCategory
    
    // Pre-computed hex color if category == .color
    var hexColorString: String?
    
    init(content: String, imagePath: String? = nil, thumbnailPath: String? = nil, sourceBundleID: String? = nil, sourceName: String? = nil) {
        self.content = content
        self.imagePath = imagePath
        self.thumbnailPath = thumbnailPath
        self.sourceAppBundleID = sourceBundleID
        self.sourceAppName = sourceName
        
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if imagePath != nil {
            self.category = .image
        } else if ClipboardItem.isValidURL(trimmed) {
            self.category = .link
        } else if let hex = ClipboardItem.extractValidHex(trimmed) {
            self.category = .color
            self.hexColorString = hex
        } else {
            self.category = .text
        }
    }
    
    // UI Helpers
    var previewText: String {
        let maxPreviewLength = 150
        let trimmed = content.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count > maxPreviewLength {
            let index = trimmed.index(trimmed.startIndex, offsetBy: maxPreviewLength)
            return String(trimmed[..<index]) + "..."
        }
        return trimmed
    }
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    // Static Helpers for Evaluation
    private static func isValidURL(_ string: String) -> Bool {
        if string.count > 2048 { return false }
        
        guard let url = URL(string: string) else { return false }
        guard let scheme = url.scheme?.lowercased() else { return false }
        
        // Exclude file URLs as they are just paths on disk
        return ["http", "https"].contains(scheme) && url.host != nil
    }
    
    private static func extractValidHex(_ string: String) -> String? {
        // Hex pattern: optionally starts with #, then exactly 3 or 6 hex chars
        let pattern = "^#?([A-Fa-f0-9]{6}|[A-Fa-f0-9]{3})$"
        if string.range(of: pattern, options: .regularExpression) != nil {
            var hexSanitized = string.replacingOccurrences(of: "#", with: "")
            // Normalize to 6 characters if it's 3
            if hexSanitized.count == 3 {
                let r = String(hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 0)])
                let g = String(hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 1)])
                let b = String(hexSanitized[hexSanitized.index(hexSanitized.startIndex, offsetBy: 2)])
                hexSanitized = r + r + g + g + b + b
            }
            return "#" + hexSanitized.uppercased()
        }
        return nil
    }
}
