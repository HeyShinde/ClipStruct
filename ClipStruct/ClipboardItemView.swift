import SwiftUI

struct ClipboardItemView: View {
    let item: ClipboardItem
    let index: Int
    let showHotkey: Bool
    let searchText: String
    let onCopy: () -> Void
    let onDelete: () -> Void
    @State private var isHovered = false
    @State private var showingDeleteConfirmation = false
    @State private var showCopiedMessage = false
    
    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            // Hotkey number indicator
            if showHotkey {
                VStack {
                    Text("⌘\(index + 1)")
                        .font(.caption2)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 3)
                                .fill(Color.blue.opacity(0.1))
                        )
                    
                    Spacer()
                }
                .frame(width: 35)
            }
            
            // Main content area - fixed width to prevent shifting
            VStack(alignment: .leading, spacing: 4) {
                // Highlighted text or regular text
                if !searchText.isEmpty {
                    HighlightedText(text: item.preview, searchText: searchText)
                        .font(.system(.body, design: .monospaced))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                } else {
                    Text(item.preview)
                        .font(.system(.body, design: .monospaced))
                        .lineLimit(3)
                        .multilineTextAlignment(.leading)
                }
                
                HStack {
                    if showCopiedMessage {
                        Text("Copied!")
                            .font(.caption2)
                            .foregroundColor(.green)
                            .fontWeight(.medium)
                    } else {
                        Text(item.timeAgo)
                            .font(.caption2)
                            .foregroundColor(.secondary)
                        
                        if !item.contentStats.isEmpty {
                            Text("•")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            
                            Text(item.contentStats)
                                .font(.caption2)
                                .foregroundColor(.secondary)
                        }
                        
                        // Show search match indicator
                        if !searchText.isEmpty {
                            Text("•")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                            
                            Text("match")
                                .font(.caption2)
                                .foregroundColor(.blue)
                                .fontWeight(.medium)
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            // Action buttons area - fixed width to prevent layout shifts
            HStack(spacing: 4) {
                if isHovered {
                    Button(action: {
                        onCopy()
                        showCopiedFeedback()
                    }) {
                        Image(systemName: "doc.on.doc")
                            .font(.caption)
                            .foregroundColor(.blue)
                    }
                    .buttonStyle(.borderless)
                    .help("Copy to clipboard")
                    
                    Button(action: {
                        showingDeleteConfirmation = true
                    }) {
                        Image(systemName: "trash")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.borderless)
                    .help("Delete item")
                }
            }
            .frame(width: 60, alignment: .trailing)
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 6)
                .fill(isHovered ? Color.gray.opacity(0.1) : Color.clear)
        )
        .onHover { hovering in
            withAnimation(.easeInOut(duration: 0.15)) {
                isHovered = hovering
            }
        }
        .onTapGesture {
            onCopy()
            showCopiedFeedback()
        }
        .contextMenu {
            Button("Copy") {
                onCopy()
                showCopiedFeedback()
            }
            
            if showHotkey {
                Button("Copy with ⌘\(index + 1)") {
                    onCopy()
                    showCopiedFeedback()
                }
            }
            
            Divider()
            
            Button("Delete", role: .destructive) {
                showingDeleteConfirmation = true
            }
        }
        .alert("Delete Item", isPresented: $showingDeleteConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Delete", role: .destructive) {
                onDelete()
            }
        } message: {
            Text("Are you sure you want to delete this clipboard item?")
        }
    }
    
    private func showCopiedFeedback() {
        withAnimation(.easeInOut(duration: 0.2)) {
            showCopiedMessage = true
        }
        
        // Hide the message after 1.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation(.easeInOut(duration: 0.2)) {
                showCopiedMessage = false
            }
        }
    }
}

// Helper view for highlighting search text
struct HighlightedText: View {
    let text: String
    let searchText: String
    
    var body: some View {
        let components = text.components(separatedBy: searchText)
        
        if components.count > 1 {
            HStack(spacing: 0) {
                ForEach(0..<components.count, id: \.self) { index in
                    Text(components[index])
                    
                    if index < components.count - 1 {
                        Text(searchText)
                            .background(Color.yellow.opacity(0.3))
                            .fontWeight(.semibold)
                    }
                }
            }
        } else {
            Text(text)
        }
    }
}
