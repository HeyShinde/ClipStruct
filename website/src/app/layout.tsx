import type { Metadata } from 'next'
import { Inter } from 'next/font/google'
import './globals.css'

const inter = Inter({ subsets: ['latin'], variable: '--font-inter' })

export const metadata: Metadata = {
    title: 'ClipStruct — Premium macOS Clipboard Manager',
    description: 'The most intelligent clipboard manager for macOS. Beautiful UI, lightning-fast search, smart categorization, and complete privacy. Free forever.',
    keywords: 'clipboard manager, macOS, productivity, clipboard history, copy paste, menu bar app',
    authors: [{ name: 'HeyShinde' }],
    openGraph: {
        title: 'ClipStruct — Premium macOS Clipboard Manager',
        description: 'The most intelligent clipboard manager for macOS. Beautiful UI, lightning-fast search, smart categorization, and complete privacy.',
        url: 'https://clipstruct.shindeaditya.com',
        siteName: 'ClipStruct',
        images: [{ url: '/og.png', width: 1200, height: 630, alt: 'ClipStruct' }],
        locale: 'en_US',
        type: 'website',
    },
    twitter: {
        card: 'summary_large_image',
        title: 'ClipStruct — Premium macOS Clipboard Manager',
        description: 'The most intelligent clipboard manager for macOS.',
        images: ['/og.png'],
    },
}

export default function RootLayout({ children }: { children: React.ReactNode }) {
    return (
        <html lang="en" className={inter.variable}>
            <head>
                <link rel="icon" href="favicon.ico" sizes="any" />
            </head>
            <body className="antialiased">
                {children}
            </body>
        </html>
    )
}
