'use client'

import { motion } from 'framer-motion'
import { LuDownload, LuGithub, LuSparkle } from 'react-icons/lu'
import Link from 'next/link'

const stats = [
    { value: '500+', label: 'Items Stored' },
    { value: '100%', label: 'Private' },
    { value: '0', label: 'Trackers' },
    { value: 'Free', label: 'Forever' },
]

export default function Hero() {
    return (
        <section className="relative min-h-screen flex flex-col items-center justify-center pt-32 overflow-hidden">
            {/* Background orbs */}
            <div className="absolute inset-0 pointer-events-none">
                <div className="orb-1 absolute top-1/4 left-1/4 w-[500px] h-[500px] rounded-full"
                    style={{ background: 'radial-gradient(circle, rgba(139,92,246,0.12) 0%, transparent 70%)' }} />
                <div className="orb-2 absolute bottom-1/4 right-1/4 w-[400px] h-[400px] rounded-full"
                    style={{ background: 'radial-gradient(circle, rgba(99,102,241,0.1) 0%, transparent 70%)' }} />
                <div className="orb-3 absolute top-1/2 left-1/2 -translate-x-1/2 -translate-y-1/2 w-[600px] h-[600px] rounded-full"
                    style={{ background: 'radial-gradient(circle, rgba(168,85,247,0.05) 0%, transparent 70%)' }} />
            </div>

            {/* Grid overlay */}
            <div className="absolute inset-0 pointer-events-none opacity-[0.03]"
                style={{
                    backgroundImage: `linear-gradient(rgba(255,255,255,0.1) 1px, transparent 1px), linear-gradient(90deg, rgba(255,255,255,0.1) 1px, transparent 1px)`,
                    backgroundSize: '64px 64px'
                }} />

            <div className="relative z-10 max-w-6xl mx-auto px-6 text-center">
                {/* Badge */}
                <motion.div
                    initial={{ opacity: 0, y: 16 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.5 }}
                    className="inline-flex mb-8"
                >
                    <span className="badge">
                        <LuSparkle size={12} className="text-violet-400" />
                        Version 2.0.2 is here — Rebuilt from scratch
                    </span>
                </motion.div>

                {/* Headline */}
                <motion.h1
                    initial={{ opacity: 0, y: 24 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.6, delay: 0.1 }}
                    className="text-5xl sm:text-6xl md:text-7xl font-bold tracking-tight leading-[1.08] mb-6"
                >
                    Your clipboard,{' '}
                    <span className="gradient-text">finally evolved.</span>
                </motion.h1>

                {/* Sub-headline */}
                <motion.p
                    initial={{ opacity: 0, y: 24 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.6, delay: 0.2 }}
                    className="text-lg md:text-xl text-slate-400 max-w-2xl mx-auto mb-10 leading-relaxed"
                >
                    ClipStruct sits silently in your menu bar and remembers everything you copy — text, images, links, and colors — so you never have to.
                </motion.p>

                {/* CTAs */}
                <motion.div
                    initial={{ opacity: 0, y: 24 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.6, delay: 0.3 }}
                    className="flex flex-wrap items-center justify-center gap-4 mb-16"
                >
                    <Link
                        href="https://github.com/HeyShinde/ClipStruct/releases/download/v2.0.2/ClipStruct-2.0.2.dmg"
                        className="btn-primary flex items-center gap-2.5 text-base !py-3.5 !px-7"
                    >
                        <LuDownload size={18} />
                        Download Free
                    </Link>
                    <Link
                        href="https://github.com/HeyShinde/ClipStruct"
                        target="_blank"
                        className="btn-ghost flex items-center gap-2.5 text-base !py-3.5 !px-7"
                    >
                        <LuGithub size={18} />
                        View on GitHub
                    </Link>
                </motion.div>

                {/* macOS badge */}
                <motion.p
                    initial={{ opacity: 0 }}
                    animate={{ opacity: 1 }}
                    transition={{ delay: 0.5 }}
                    className="text-xs text-slate-600 mb-16"
                >
                    macOS 14+ • Apple Silicon & Intel • Free forever
                </motion.p>

                {/* Stats row */}
                <motion.div
                    initial={{ opacity: 0, y: 32 }}
                    animate={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.7, delay: 0.4 }}
                    className="grid grid-cols-2 md:grid-cols-4 gap-px glass rounded-2xl overflow-hidden max-w-2xl mx-auto mb-20"
                >
                    {stats.map(stat => (
                        <div key={stat.label} className="flex flex-col items-center py-6 px-4 bg-white/[0.02]">
                            <span className="text-2xl font-bold text-white mb-1">{stat.value}</span>
                            <span className="text-xs text-slate-500 uppercase tracking-wider">{stat.label}</span>
                        </div>
                    ))}
                </motion.div>

                {/* App screenshot mockup */}
                <motion.div
                    initial={{ opacity: 0, y: 48, scale: 0.97 }}
                    animate={{ opacity: 1, y: 0, scale: 1 }}
                    transition={{ duration: 0.9, delay: 0.5, ease: [0.22, 1, 0.36, 1] }}
                    className="relative mx-auto max-w-3xl"
                >
                    {/* Glow behind mockup */}
                    <div className="absolute -inset-8 rounded-3xl opacity-30"
                        style={{ background: 'radial-gradient(ellipse, rgba(139,92,246,0.3) 0%, transparent 70%)' }} />

                    {/* App window mockup */}
                    <div className="relative glass rounded-2xl overflow-hidden border border-white/[0.08] glow-violet">
                        {/* Window chrome */}
                        <div className="flex items-center gap-2 px-4 py-3 bg-white/[0.03] border-b border-white/[0.06]">
                            <div className="w-3 h-3 rounded-full bg-red-500/80" />
                            <div className="w-3 h-3 rounded-full bg-yellow-500/80" />
                            <div className="w-3 h-3 rounded-full bg-green-500/80" />
                            <div className="ml-4 flex-1 bg-white/[0.05] rounded-md h-5 max-w-[200px]" />
                        </div>

                        {/* App content preview */}
                        <div className="flex h-64 md:h-80">
                            {/* Sidebar */}
                            <div className="w-16 bg-white/[0.02] border-r border-white/[0.05] flex flex-col items-center py-4 gap-5">
                                {['🗂️', '📝', '🖼️', '🔗', '🎨'].map((emoji, i) => (
                                    <div key={i} className={`w-9 h-9 rounded-xl flex items-center justify-center text-base transition-all ${i === 0 ? 'bg-violet-600/80' : 'hover:bg-white/5'}`}>
                                        {emoji}
                                    </div>
                                ))}
                            </div>

                            {/* Main content */}
                            <div className="flex-1 p-4 flex flex-col gap-3">
                                {/* Search bar */}
                                <div className="glass rounded-lg px-3 py-2 flex items-center gap-2">
                                    <div className="w-4 h-4 rounded bg-white/10" />
                                    <div className="h-3 bg-white/[0.06] rounded flex-1" />
                                </div>

                                {/* Cards */}
                                {[
                                    { color: 'violet', lines: 2, label: 'Text' },
                                    { color: 'blue', lines: 1, label: 'Link' },
                                    { color: 'purple', lines: 3, label: 'Text' },
                                    { color: 'pink', lines: 1, label: 'Color' },
                                ].map((card, i) => (
                                    <div key={i} className="glass rounded-lg p-3 flex flex-col gap-2">
                                        <div className="flex items-center gap-2 mb-1">
                                            <div className={`w-3 h-3 rounded-full bg-${card.color}-500/60`} />
                                            <div className="h-2.5 bg-white/[0.08] rounded w-16" />
                                            <div className="ml-auto h-2 bg-white/[0.05] rounded w-10" />
                                        </div>
                                        {Array.from({ length: card.lines }).map((_, li) => (
                                            <div key={li} className={`h-2.5 bg-white/[0.06] rounded ${li === card.lines - 1 && card.lines > 1 ? 'w-3/5' : 'w-full'}`} />
                                        ))}
                                    </div>
                                ))}
                            </div>
                        </div>
                    </div>
                </motion.div>
            </div>
        </section>
    )
}
