'use client'

import { motion } from 'framer-motion'
import {
    LuSearch, LuKeyboard, LuShield,
    LuZap, LuMonitor, LuImage, LuLink, LuPalette, LuEye
} from 'react-icons/lu'

const features = [
    {
        icon: LuZap,
        title: 'Instant Capture',
        description: 'Copies appear in your history the moment you press ⌘C. No lag, no delay — it\'s always watching.',
        color: 'text-yellow-400',
        bg: 'bg-yellow-500/10',
    },
    {
        icon: LuSearch,
        title: 'Universal Search',
        description: 'Search by content or source app. Find anything in milliseconds, even by the app you copied it from.',
        color: 'text-blue-400',
        bg: 'bg-blue-500/10',
    },
    {
        icon: LuImage,
        title: 'Images & Visuals',
        description: 'Copy screenshots, photos, and graphics. ClipStruct stores them with smart thumbnail generation.',
        color: 'text-purple-400',
        bg: 'bg-purple-500/10',
    },
    {
        icon: LuLink,
        title: 'Link Detection',
        description: 'URLs are automatically detected and displayed as rich link cards — clean and easy to navigate.',
        color: 'text-cyan-400',
        bg: 'bg-cyan-500/10',
    },
    {
        icon: LuPalette,
        title: 'Color Swatches',
        description: 'Hex codes are recognized and shown as beautiful color swatches. Designers will love this.',
        color: 'text-pink-400',
        bg: 'bg-pink-500/10',
    },
    {
        icon: LuShield,
        title: 'Privacy by Design',
        description: 'Zero network access. Zero telemetry. All data lives exclusively on your Mac. Forever.',
        color: 'text-green-400',
        bg: 'bg-green-500/10',
    },
    {
        icon: LuKeyboard,
        title: 'Global Hotkeys',
        description: 'Summon ClipStruct instantly from anywhere with your custom keyboard shortcut.',
        color: 'text-violet-400',
        bg: 'bg-violet-500/10',
    },
    {
        icon: LuMonitor,
        title: 'Menu Bar Native',
        description: 'Lives quietly in your menu bar. No Dock icon, no clutter. Just there when you need it.',
        color: 'text-indigo-400',
        bg: 'bg-indigo-500/10',
    },
    {
        icon: LuEye,
        title: 'Smart Deduplication',
        description: 'Copy something twice? It simply floats to the top instead of cluttering your history.',
        color: 'text-orange-400',
        bg: 'bg-orange-500/10',
    },
]

const container = {
    hidden: {},
    visible: { transition: { staggerChildren: 0.07 } }
}

const item = {
    hidden: { opacity: 0, y: 20 },
    visible: { opacity: 1, y: 0, transition: { duration: 0.5, ease: [0.22, 1, 0.36, 1] as [number, number, number, number] } }
}

export default function Features() {
    return (
        <section id="features" className="section-padding relative">
            <div className="max-w-6xl mx-auto px-6">
                {/* Header */}
                <motion.div
                    initial={{ opacity: 0, y: 24 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    transition={{ duration: 0.6 }}
                    className="text-center mb-20"
                >
                    <span className="badge mb-6 inline-flex">Everything you need</span>
                    <h2 className="text-4xl md:text-5xl font-bold tracking-tight mb-5">
                        Powerful. <span className="gradient-text">Private. Precise.</span>
                    </h2>
                    <p className="text-lg text-slate-400 max-w-2xl mx-auto">
                        Built for professionals who copy a lot and can&apos;t afford to lose track of their work.
                    </p>
                </motion.div>

                {/* Feature grid */}
                <motion.div
                    variants={container}
                    initial="hidden"
                    whileInView="visible"
                    viewport={{ once: true, amount: 0.1 }}
                    className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 gap-4"
                >
                    {features.map((feature) => (
                        <motion.div
                            key={feature.title}
                            variants={item}
                            className="glass rounded-2xl p-6 group cursor-default"
                        >
                            <div className={`inline-flex items-center justify-center w-11 h-11 rounded-xl ${feature.bg} mb-4 transition-transform duration-300 group-hover:scale-110`}>
                                <feature.icon className={`${feature.color} icon-glow`} size={22} />
                            </div>
                            <h3 className="text-base font-semibold text-white mb-2">{feature.title}</h3>
                            <p className="text-sm text-slate-400 leading-relaxed">{feature.description}</p>
                        </motion.div>
                    ))}
                </motion.div>
            </div>
        </section>
    )
}
