import type { Metadata, Viewport } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' })

const siteUrl = 'https://clipstruct.shindeaditya.com'

export const viewport: Viewport = {
    themeColor: '#050508',
    width: 'device-width',
    initialScale: 1,
}

export const metadata: Metadata = {
    metadataBase: new URL(siteUrl),
    title: {
        default: 'ClipStruct — Premium Native macOS Clipboard Manager',
        template: '%s | ClipStruct',
    },
    description:
        'ClipStruct is a lightning-fast, native macOS clipboard manager. Seamlessly store text, images, colors, and links with instant global hotkey search, smart categorization, zero telemetry, and 100% on-device privacy.',
    keywords: [
        'ClipStruct',
        'macOS clipboard manager',
        'mac clipboard history',
        'clipboard manager Mac',
        'native Swift macOS app',
        'clipboard organizer',
        'menu bar app',
        'copy paste history Mac',
        'privacy focused clipboard manager',
        'HeyShinde',
        'Aditya Shinde',
    ],
    authors: [{ name: 'Aditya Shinde', url: 'https://shindeaditya.com' }],
    creator: 'Aditya Shinde',
    publisher: 'Aditya Shinde',
    applicationName: 'ClipStruct',
    category: 'Productivity',
    alternates: {
        canonical: siteUrl,
    },
    robots: {
        index: true,
        follow: true,
        googleBot: {
            index: true,
            follow: true,
            'max-video-preview': -1,
            'max-image-preview': 'large',
            'max-snippet': -1,
        },
    },
    openGraph: {
        title: 'ClipStruct — Premium Native macOS Clipboard Manager',
        description:
            'The most intelligent clipboard manager for macOS. Lightning-fast search, smart categorization, instant hotkeys, and 100% on-device privacy. Free forever.',
        url: siteUrl,
        siteName: 'ClipStruct',
        locale: 'en_US',
        type: 'website',
    },
    twitter: {
        card: 'summary_large_image',
        title: 'ClipStruct — Premium Native macOS Clipboard Manager',
        description:
            'Intelligent native macOS clipboard manager. Search history instantly, manage snippets, and keep your data 100% on-device.',
        creator: '@HeyShinde',
    },
    icons: {
        icon: '/favicon.ico',
        shortcut: '/favicon.ico',
        apple: '/icon.png',
    },
    verification: {
        google: process.env.NEXT_PUBLIC_GOOGLE_SITE_VERIFICATION,
    },
}

const jsonLd = {
    '@context': 'https://schema.org',
    '@graph': [
        {
            '@type': 'WebSite',
            '@id': `${siteUrl}/#website`,
            url: siteUrl,
            name: 'ClipStruct',
            description: 'Premium native macOS clipboard manager for enhanced productivity.',
            publisher: {
                '@type': 'Person',
                name: 'Aditya Shinde',
                url: 'https://shindeaditya.com',
            },
            inLanguage: 'en-US',
        },
        {
            '@type': 'SoftwareApplication',
            '@id': `${siteUrl}/#application`,
            name: 'ClipStruct',
            headline: 'Premium Native macOS Clipboard Manager',
            operatingSystem: 'macOS 14.0 or later',
            applicationCategory: 'UtilitiesApplication',
            applicationSubCategory: 'Clipboard Manager',
            offers: {
                '@type': 'Offer',
                price: '0',
                priceCurrency: 'USD',
                availability: 'https://schema.org/InStock',
            },
            description:
                'ClipStruct sits silently in your macOS menu bar and remembers everything you copy — text, images, links, code, and colors. Features global hotkeys, instant fuzzy search, and zero network telemetry.',
            url: siteUrl,
            downloadUrl: 'https://github.com/HeyShinde/ClipStruct/releases/latest',
            screenshot: `${siteUrl}/opengraph-image`,
            softwareVersion: '2.0.2',
            author: {
                '@type': 'Person',
                name: 'Aditya Shinde',
                url: 'https://shindeaditya.com',
            },
        },
    ],
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
    return (
        <html lang="en" className={inter.variable}>
            <head>
                <script
                    type="application/ld+json"
                    dangerouslySetInnerHTML={{ __html: JSON.stringify(jsonLd) }}
                />
            </head>
            <body className="antialiased">
                {children}
            </body>
        </html>
    )
}
