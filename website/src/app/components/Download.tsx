'use client'

import { motion } from 'framer-motion'
import { LuDownload, LuGithub, LuCheck, LuShieldCheck } from 'react-icons/lu'
import Link from 'next/link'
import Image from 'next/image'

const steps = [
    { step: '1', text: 'Download ClipStruct-2.0.1.dmg' },
    { step: '2', text: 'Open the DMG and drag ClipStruct to Applications' },
    { step: '3', text: 'Right-click → Open on first launch' },
    { step: '4', text: 'Click the menu bar icon and start copying!' },
]

const included = [
    'Unlimited clipboard history',
    'Smart content categorization',
    'Image & link support',
    'Password manager exclusions',
    'Global keyboard shortcut',
    'Future updates free',
]

export default function Download() {
    return (
        <section id="download" className="section-padding relative">
            {/* Background accent */}
            <div className="absolute inset-0 pointer-events-none overflow-hidden">
                <div className="absolute -bottom-32 left-1/2 -translate-x-1/2 w-[800px] h-[400px] rounded-full opacity-20"
                    style={{ background: 'radial-gradient(ellipse, rgba(139,92,246,0.4) 0%, transparent 70%)' }} />
            </div>

            <div className="max-w-6xl mx-auto px-6 relative z-10">
                <motion.div
                    initial={{ opacity: 0, y: 24 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    viewport={{ once: true }}
                    transition={{ duration: 0.6 }}
                    className="text-center mb-16"
                >
                    <span className="badge mb-6 inline-flex">Free. No catch.</span>
                    <h2 className="text-4xl md:text-5xl font-bold tracking-tight mb-5">
                        Ready to{' '}
                        <span className="gradient-text">supercharge</span>{' '}
                        your workflow?
                    </h2>
                    <p className="text-lg text-slate-400 max-w-xl mx-auto">
                        Download ClipStruct in seconds. No account, no subscription, no data collection.
                    </p>
                </motion.div>

                <div className="grid lg:grid-cols-5 gap-6 items-start">
                    {/* Download card — 3 cols */}
                    <motion.div
                        initial={{ opacity: 0, x: -24 }}
                        whileInView={{ opacity: 1, x: 0 }}
                        viewport={{ once: true }}
                        transition={{ duration: 0.6 }}
                        className="lg:col-span-3 glass rounded-2xl p-8 glow-violet"
                    >
                        {/* App info */}
                        <div className="flex items-center gap-5 mb-8 pb-8 border-b border-white/[0.06]">
                            <div className="w-20 h-20 rounded-2xl overflow-hidden ring-2 ring-violet-500/20 flex-shrink-0">
                                <Image src="/icon.png" width={80} height={80} alt="ClipStruct" className="w-full h-full object-cover" />
                            </div>
                            <div>
                                <div className="flex items-center gap-3 mb-2">
                                    <h3 className="text-xl font-semibold text-white">macOS</h3>
                                    <span className="badge !text-xs !py-0.5 !px-2">v2.0.1</span>
                                </div>
                                <p className="text-sm text-slate-400 mb-1">For macOS 14.0 Sonoma and later</p>
                                <p className="text-xs text-slate-600">2.6 MB • Universal Binary • Free</p>
                            </div>
                        </div>

                        {/* What's included */}
                        <h4 className="text-sm font-semibold text-slate-300 mb-4 uppercase tracking-wider">What&apos;s included</h4>
                        <div className="grid grid-cols-1 sm:grid-cols-2 gap-2.5 mb-8">
                            {included.map(item => (
                                <div key={item} className="flex items-center gap-2.5 text-sm text-slate-300">
                                    <LuCheck size={15} className="text-violet-400 flex-shrink-0" />
                                    {item}
                                </div>
                            ))}
                        </div>

                        {/* Download buttons */}
                        <div className="flex flex-col sm:flex-row gap-3">
                            <Link
                                href="https://github.com/HeyShinde/ClipStruct/releases/download/v2.0.1/ClipStruct-2.0.1.dmg"
                                className="btn-primary flex items-center justify-center gap-2.5 flex-1 !py-3.5"
                            >
                                <LuDownload size={18} />
                                Download DMG
                            </Link>
                            <Link
                                href="https://github.com/HeyShinde/ClipStruct/releases/tag/v2.0.1"
                                target="_blank"
                                className="btn-ghost flex items-center justify-center gap-2.5 flex-1 !py-3.5"
                            >
                                <LuGithub size={18} />
                                View Release
                            </Link>
                        </div>
                    </motion.div>

                    {/* Right column — 2 cols */}
                    <div className="lg:col-span-2 flex flex-col gap-5">
                        {/* Installation steps */}
                        <motion.div
                            initial={{ opacity: 0, x: 24 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.6, delay: 0.1 }}
                            className="glass rounded-2xl p-6"
                        >
                            <h4 className="text-sm font-semibold text-slate-300 mb-5 uppercase tracking-wider">Installation</h4>
                            <div className="flex flex-col gap-4">
                                {steps.map((s) => (
                                    <div key={s.step} className="flex items-start gap-3">
                                        <div className="w-6 h-6 rounded-full bg-violet-500/20 border border-violet-500/30 flex items-center justify-center text-xs font-bold text-violet-400 flex-shrink-0 mt-0.5">
                                            {s.step}
                                        </div>
                                        <span className="text-sm text-slate-300 leading-relaxed">{s.text}</span>
                                    </div>
                                ))}
                            </div>
                        </motion.div>

                        {/* Security notice */}
                        <motion.div
                            initial={{ opacity: 0, x: 24 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.6, delay: 0.2 }}
                            className="glass rounded-2xl p-6"
                        >
                            <div className="flex items-center gap-2.5 mb-4">
                                <LuShieldCheck size={18} className="text-green-400" />
                                <h4 className="text-sm font-semibold text-slate-300 uppercase tracking-wider">Security Notice</h4>
                            </div>
                            <p className="text-sm text-slate-400 leading-relaxed">
                                ClipStruct is not Apple-notarized (we&apos;re indie). On first launch, right-click → <strong className="text-slate-300">Open</strong>, or go to System Settings → Privacy & Security → <strong className="text-slate-300">Open Anyway</strong>.
                            </p>
                        </motion.div>
                    </div>
                </div>
            </div>
        </section>
    )
}
