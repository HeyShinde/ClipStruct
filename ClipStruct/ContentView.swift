import SwiftUI
import KeyboardShortcuts

struct ContentView: View {
    @EnvironmentObject var clipboardManager: ClipboardManager
    @EnvironmentObject var preferencesManager: PreferencesManager
    @State private var showingPreferences = false
    @State private var showingAbout = false
    @State private var showingClearAllConfirmation = false
    @State private var showToast = false
    @State private var toastMessage = ""
    @State private var searchText = ""
    @FocusState private var isSearchFocused: Bool
    
    // Computed property for filtered items
    private var filteredItems: [ClipboardItem] {
        if searchText.isEmpty {
            return clipboardManager.items
        } else {
            return clipboardManager.items.filter { item in
                item.content.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Header with search
            headerView
            
            Divider()
            
            // Search bar
            searchBarView
            
            Divider()
            
            // Clipboard items
            if clipboardManager.items.isEmpty {
                emptyStateView
            } else if filteredItems.isEmpty && !searchText.isEmpty {
                noSearchResultsView
            } else {
                clipboardItemsList
            }
            
            Divider()
            
            // Footer with preferences
            footerView
        }
        .frame(width: 350, height: 500)
        .toast(message: toastMessage, isShowing: $showToast)
        .sheet(isPresented: $showingPreferences) {
            PreferencesView()
                .environmentObject(preferencesManager)
        }
        .sheet(isPresented: $showingAbout) {
            AboutView()
        }
        .alert("Clear All Items", isPresented: $showingClearAllConfirmation) {
            Button("Cancel", role: .cancel) { }
            Button("Clear All", role: .destructive) {
                clipboardManager.clearAll()
            }
        } message: {
            Text("Are you sure you want to clear all \(clipboardManager.items.count) clipboard items? This action cannot be undone.")
        }
        .onReceive(clipboardManager.$lastCopiedItem) { item in
            if let item = item {
                showCopyToast(for: item)
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: .popoverDidOpen)) { _ in
            // Focus search when popover opens
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isSearchFocused = true
            }
        }
        .onAppear {
            // Auto-focus search when popover appears
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isSearchFocused = true
            }
        }
        .onDisappear {
            // Clear search when popover closes for better UX
            searchText = ""
        }
    }
    
    private var headerView: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                Text("ClipStruct")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Text("⌘⇧C to toggle • ⌘1...⌘9 to copy")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                // Search results counter
                if !searchText.isEmpty {
                    Text("\(filteredItems.count) found")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color.blue.opacity(0.1))
                        )
                }
                
                if !clipboardManager.items.isEmpty {
                    Button(action: {
                        showingClearAllConfirmation = true
                    }) {
                        Image(systemName: "trash")
                            .font(.caption)
                            .foregroundColor(.red)
                    }
                    .buttonStyle(.borderless)
                    .help("Clear all items")
                }
                
                Text("\(clipboardManager.items.count)/100")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var searchBarView: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.system(size: 14))
            
            TextField("Search clipboard items...", text: $searchText)
                .textFieldStyle(.plain)
                .focused($isSearchFocused)
                .onSubmit {
                    // If there's exactly one result, copy it
                    if filteredItems.count == 1 {
                        let item = filteredItems[0]
                        clipboardManager.copyToPasteboardAndClose(item.content)
                        showCopyToast(for: item)
                    }
                }
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    isSearchFocused = true
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 14))
                }
                .buttonStyle(.borderless)
                .help("Clear search")
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.gray.opacity(0.1))
        )
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
    
    private var noSearchResultsView: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            Text("No results found")
                .font(.title3)
                .fontWeight(.medium)
            
            Text("Try a different search term")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Button("Clear Search") {
                searchText = ""
                isSearchFocused = true
            }
            .buttonStyle(.borderless)
            .foregroundStyle(.blue)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var emptyStateView: some View {
        VStack(spacing: 16) {
            Image(systemName: "doc.on.clipboard")
                .font(.system(size: 48))
                .foregroundColor(.secondary)
            
            Text("No clipboard items yet")
                .font(.title3)
                .fontWeight(.medium)
            
            VStack(spacing: 4) {
                Text("Copy something to get started")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Text("Use ⌘1, ⌘2, ... ⌘9 for quick access")
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    private var clipboardItemsList: some View {
        ScrollView {
            LazyVStack(spacing: 8) {
                ForEach(Array(filteredItems.enumerated()), id: \.element.id) { index, item in
                    let originalIndex = clipboardManager.items.firstIndex(where: { $0.id == item.id }) ?? 0
                    
                    ClipboardItemView(
                        item: item,
                        index: originalIndex,
                        showHotkey: originalIndex < 9 && searchText.isEmpty, // Only show hotkeys when not searching
                        searchText: searchText,
                        onCopy: {
                            clipboardManager.copyToPasteboardAndClose(item.content)
                            showCopyToast(for: item)
                        },
                        onDelete: {
                            clipboardManager.removeItem(item)
                        }
                    )
                }
            }
            .padding()
        }
    }
    
    private var footerView: some View {
        HStack(spacing: 16) {
            Button("Preferences") {
                showingPreferences = true
            }
            .buttonStyle(.borderless)
            
            Button("About") {
                showingAbout = true
            }
            .buttonStyle(.borderless)
            
            Spacer()
            
            Button("Quit") {
                NSApplication.shared.terminate(nil)
            }
            .buttonStyle(.borderless)
            .foregroundColor(.red)
        }
        .padding()
    }
    
    private func showCopyToast(for item: ClipboardItem) {
        toastMessage = "Copied: \(item.preview)"
        showToast = true
        
        // Auto-hide toast after 1.5 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            showToast = false
        }
    }
}
