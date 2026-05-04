import type { Metadata } from 'next'
import './globals.css'

export const metadata: Metadata = {
    title: 'ClipStruct - The Ultimate macOS Clipboard Manager',
    description: 'A powerful, privacy-focused clipboard manager for macOS. Store 100+ items, use global hotkeys, and never lose important clipboard content again.',
    keywords: 'clipboard manager, macOS, productivity, clipboard history, copy paste',
    authors: [{ name: 'ClipStruct Team' }],
    openGraph: {
        title: 'ClipStruct - The Ultimate macOS Clipboard Manager',
        description: 'A powerful, privacy-focused clipboard manager for macOS. Store 100+ items, use global hotkeys, and never lose important clipboard content again.',
        url: 'https://clipstruct.heyshinde.com',
        siteName: 'ClipStruct',
        images: [
            {
                url: '/app-screenshot.png',
                width: 1200,
                height: 630,
                alt: 'ClipStruct App Screenshot',
            },
        ],
        locale: 'en_US',
        type: 'website',
    },
    twitter: {
        card: 'summary_large_image',
        title: 'ClipStruct - The Ultimate macOS Clipboard Manager',
        description: 'A powerful, privacy-focused clipboard manager for macOS.',
        images: ['/app-screenshot.png'],
    },
}

export default function RootLayout({
                                       children,
                                   }: {
    children: React.ReactNode
}) {
    return (
        <html lang="en">
        <head>
            <link rel="icon" href="favicon.ico" sizes="any" />
        </head>
        <body className="bg-gradient-to-br from-slate-900 via-blue-900 to-slate-900 text-white min-h-screen">
        {children}
        </body>
        </html>
    )
}
