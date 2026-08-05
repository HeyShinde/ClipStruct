import Foundation
import SwiftUI

enum ItemCategory: String, Codable, CaseIterable {
    case all = "All Items"
    case text = "Text"
    case image = "Images"
    case link = "Links"
    case color = "Colors"
    
    var iconName: String {
        switch self {
        case .all: return "tray.2.fill"
        case .text: return "doc.text.fill"
        case .image: return "photo.fill"
        case .link: return "link"
        case .color: return "paintpalette.fill"
        }
    }
    
    var themeColor: Color {
        switch self {
        case .all: return .primary
        case .text: return .blue
        case .image: return .purple
        case .link: return .green
        case .color: return .orange
        }
    }
}
