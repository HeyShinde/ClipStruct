<div align="center">
  <img src="./website/public/icon.png" width="128" alt="ClipStruct Icon" />
  <h1>ClipStruct</h1>
  <p><strong>The ultimate, privacy-first macOS clipboard manager built with SwiftUI.</strong></p>
  
  <p>
    <a href="https://clipstruct.shindeaditya.com">Website</a> •
    <a href="https://github.com/HeyShinde/ClipStruct/releases">Download</a> •
    <a href="https://github.com/HeyShinde/ClipStruct/releases/latest">Release Notes</a>
  </p>
</div>

---

ClipStruct sits silently in your menu bar and remembers everything you copy — text, images, links, and colors — so you never have to. Completely rebuilt for version 2.3 with a lightning-fast native engine and a beautiful new interface.

## ✨ Features

- ⚡️ **Instant Capture**: Copies appear in your history the moment you press `⌘C`. No lag, no delay.
- 🔍 **Universal Search**: Search by content *or* source app. Find anything in milliseconds (e.g., search "Safari" to find all Safari copies).
- 🖼️ **Images & Visuals**: Copy screenshots, photos, and graphics. ClipStruct stores them with smart thumbnail generation.
- 🔗 **Link Detection**: URLs are automatically detected and displayed as rich link cards.
- 🎨 **Color Swatches**: Hex codes are recognized and shown as beautiful color swatches.
- ⌨️ **Global Hotkeys**: Summon ClipStruct instantly from anywhere with your custom keyboard shortcut.
- 🧠 **Smart Deduplication**: Copy something twice? It simply floats to the top instead of cluttering your history.
- 🔌 **Menu Bar Native**: Lives quietly in your menu bar. No Dock icon, no clutter.

## 🛡️ Privacy by Design

- **Zero Network Access**: ClipStruct does not connect to the internet.
- **Zero Telemetry**: We don't track how you use the app.
- **100% Local Storage**: All data lives exclusively on your Mac. Forever.
- **Password Manager Aware**: Hardcoded exclusion list for all major password managers (1Password, Bitwarden, Proton Pass, KeePass, MacPass). It respects the `ConcealedType` pasteboard flag.

## 📦 Installation

ClipStruct is a native macOS application optimized for Apple Silicon and Intel Macs running macOS 14.0 or later.

1. Go to the [Releases page](https://github.com/HeyShinde/ClipStruct/releases/latest).
2. Download the latest `ClipStruct-2.3.dmg`.
3. Open the DMG and drag ClipStruct to your Applications folder.
4. Launch the app and grant Accessibility permissions when prompted (required for global hotkeys and clipboard reading).
5. *Note: Since ClipStruct is an indie app, you may need to Right-click → **Open** on the first launch to bypass Gatekeeper.*

## 🛠️ Building from Source

If you prefer to build the app yourself, you'll need Xcode 15 or later.

```bash
# Clone the repository
git clone https://github.com/HeyShinde/ClipStruct.git

# Open the workspace
cd ClipStruct
open ClipStruct.xcodeproj/project.xcworkspace
```

1. Select the `ClipStruct` scheme.
2. Hit `⌘R` to build and run.

### Website Development

The promotional website is built with [Astro](https://astro.build) and [Tailwind CSS](https://tailwindcss.com), engineered for static performance and hosted globally on Cloudflare Pages.

```bash
cd website
npm install
npm run dev
```

## 💖 Support the Project

If you find ClipStruct useful, consider supporting its continued development!

- [GitHub Sponsors](https://github.com/sponsors/HeyShinde)
- [Buy me a coffee](https://buymeacoffee.com/heyshinde)
- [Razorpay](https://razorpay.me/@heyshinde)

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.
