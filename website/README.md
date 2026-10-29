# ClipStruct Website

The official promotional website for **[ClipStruct](https://github.com/HeyShinde/ClipStruct)** — the ultimate, privacy-first native macOS clipboard manager.

Built with [Astro](https://astro.build) and [Tailwind CSS](https://tailwindcss.com), engineered for static performance, zero runtime JavaScript bloat, and hosted globally on [Cloudflare Pages](https://pages.cloudflare.com).

## 🚀 Quick Start

### 1. Install dependencies
```bash
npm install
```

### 2. Start local development server
```bash
npm run dev
```

Visit [http://localhost:4321](http://localhost:4321) in your browser.

### 3. Build for production
```bash
npm run build
```

This generates an ultra-optimized static bundle in `dist/`.

### 4. Preview production build locally
```bash
npm run preview
```

---

## ☁️ Deploying to Cloudflare Pages

### Option A: Git Integration (Recommended)
1. In the **Cloudflare Dashboard**, navigate to **Workers & Pages** → **Create application** → **Pages** → **Connect to Git**.
2. Select the `ClipStruct` repository.
3. Configure build settings:
   - **Framework preset**: `Astro`
   - **Build command**: `npm run build` (with Root Directory set to `website`)
   - **Build output directory**: `dist`
4. Click **Save and Deploy**.

### Option B: Cloudflare Wrangler CLI
```bash
# Build the project
npm run build

# Deploy directly via Wrangler
npx wrangler pages deploy dist --project-name clipstruct-website
```

---

## ⚡ Performance & Optimization Highlights

- **0 Framework JS Bloat**: Pure static HTML & CSS rendered at build time.
- **Sub-300ms Build Times**: Fast Vite-based Astro compilation.
- **Cloudflare Edge Optimized**: Custom `_headers` file providing 1-year immutable caching for assets and strict modern security headers (HSTS, CSP, X-Frame-Options).
- **Interactive macOS Preview**: Lightweight vanilla JS demo showcasing live fuzzy search, category filtering, and instant copy swatches.
- **SEO & Social Share Ready**: Auto-generated `sitemap-index.xml`, optimized `robots.txt`, OpenGraph SVG cards, and Schema.org JSON-LD structured data.
