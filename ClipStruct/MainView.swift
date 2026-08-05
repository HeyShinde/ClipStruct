import SwiftUI

struct MainView: View {
    @EnvironmentObject private var clipboardMonitor: ClipboardMonitor
    @EnvironmentObject private var preferencesManager: PreferencesManager
    
    @State private var searchText = ""
    @State private var selectedCategory: ItemCategory = .all
    @FocusState private var isSearchFocused: Bool
    @State private var isShowingPreferences = false
    
    let columns = [
        GridItem(.adaptive(minimum: 250, maximum: 350), spacing: 16)
    ]
    
    var filteredItems: [ClipboardItem] {
        let items = clipboardMonitor.items
        
        let filteredByCategory = items.filter { item in
            if selectedCategory == .all { return true }
            return item.category == selectedCategory
        }
        
        if searchText.isEmpty {
            return filteredByCategory
        } else {
            return filteredByCategory.filter { item in
                let contentMatch = item.content.localizedCaseInsensitiveContains(searchText)
                let appMatch = item.sourceAppName?.localizedCaseInsensitiveContains(searchText) ?? false
                return contentMatch || appMatch
            }
        }
    }
    
    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            VStack(spacing: 24) {
                ForEach(ItemCategory.allCases, id: \.self) { category in
                    Button(action: { selectedCategory = category }) {
                        Image(systemName: category.iconName)
                            .font(.system(size: 20))
                            .foregroundColor(selectedCategory == category ? .white : .secondary)
                            .frame(width: 44, height: 44)
                            .background(selectedCategory == category ? category.themeColor : Color.clear)
                            .contentShape(Rectangle())
                            .cornerRadius(12)
                    }
                    .buttonStyle(.plain)
                    .help(category.rawValue)
                }
                Spacer()
                
                Button(action: { isShowingPreferences = true }) {
                    Image(systemName: "gearshape.fill")
                        .font(.system(size: 20))
                        .foregroundColor(.secondary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .help("Preferences")
                
                Button(action: { NSApp.terminate(nil) }) {
                    Image(systemName: "power")
                        .font(.system(size: 18))
                        .foregroundColor(.secondary)
                        .frame(width: 44, height: 44)
                        .contentShape(Rectangle())
                }
                .buttonStyle(.plain)
                .help("Quit ClipStruct")
            }
            .frame(width: 64)
            .padding(.top, 24)
            .padding(.bottom, 16)
            .background(Color(NSColor.windowBackgroundColor))
            
            Divider()
            
            // Main Content Area
            VStack(spacing: 0) {
                // Toolbar Area
                HStack {
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.secondary)
                        TextField("Search content or app...", text: $searchText)
                            .textFieldStyle(PlainTextFieldStyle())
                            .focused($isSearchFocused)
                        
                        if !searchText.isEmpty {
                            Button(action: { searchText = "" }) {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.secondary)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(8)
                    .background(Color(NSColor.controlBackgroundColor))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8).stroke(Color.primary.opacity(0.1), lineWidth: 1))
                    
                    Spacer(minLength: 16)
                    
                    Button(action: { clipboardMonitor.clearAll() }) {
                        HStack(spacing: 4) {
                            Image(systemName: "trash")
                            Text("Clear")
                        }
                        .foregroundColor(.red)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(6)
                    }
                    .buttonStyle(.plain)
                }
                .padding()
                .background(Color(NSColor.windowBackgroundColor))
                
                Divider()
                
                // Grid Area
                ScrollView {
                    if filteredItems.isEmpty {
                        VStack(spacing: 12) {
                            Spacer().frame(height: 100)
                            Image(systemName: selectedCategory.iconName)
                                .font(.system(size: 48))
                                .foregroundColor(.secondary.opacity(0.5))
                            Text(searchText.isEmpty ? "No items in \(selectedCategory.rawValue)" : "No results found")
                                .foregroundColor(.secondary)
                        }
                        .frame(maxWidth: .infinity)
                    } else {
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(filteredItems) { item in
                                ItemCardView(item: item) {
                                    clipboardMonitor.copyItem(item)
                                }
                            }
                        }
                        .padding(16)
                    }
                }
                .background(Color(NSColor.controlBackgroundColor).opacity(0.5))
                
                Divider()
                
                // Status Bar
                HStack {
                    Text("\(clipboardMonitor.items.count) items stored")
                        .font(.caption)
                        .foregroundColor(.secondary)
                    
                    Spacer()
                    
                    Button(action: { clipboardMonitor.togglePause() }) {
                        HStack(spacing: 4) {
                            Image(systemName: clipboardMonitor.isPaused ? "play.fill" : "pause.fill")
                            Text(clipboardMonitor.isPaused ? "Resume" : "Pause")
                        }
                        .font(.caption)
                        .foregroundColor(clipboardMonitor.isPaused ? .blue : .secondary)
                    }
                    .buttonStyle(.plain)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color(NSColor.windowBackgroundColor))
            }
        }
        .frame(minWidth: 400, minHeight: 500)
        .onReceive(NotificationCenter.default.publisher(for: .popoverDidOpen)) { _ in
            isSearchFocused = true
        }
        .sheet(isPresented: $isShowingPreferences) {
            PreferencesView()
                .environmentObject(preferencesManager)
        }
    }
}
