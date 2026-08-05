'use client'

import { motion } from 'framer-motion'
import { LuShield, LuWifi, LuDatabase, LuEye } from 'react-icons/lu'

const pillars = [
    {
        icon: LuWifi,
        title: 'Zero Network Access',
        description: 'ClipStruct never makes a network request. There\'s no server, no sync, no cloud.',
    },
    {
        icon: LuDatabase,
        title: 'Local Storage Only',
        description: 'All clipboard history is stored in ~/Application Support on your Mac. You own it.',
    },
    {
        icon: LuShield,
        title: 'Password Manager Safe',
        description: 'Items from 1Password, Bitwarden, Proton Pass and others are automatically excluded.',
    },
    {
        icon: LuEye,
        title: 'Open Source',
        description: 'Every line of code is public on GitHub. Audit it, fork it, improve it.',
    },
]

export default function Privacy() {
    return (
        <section id="privacy" className="section-padding relative">
            <div className="max-w-6xl mx-auto px-6">
                <div className="glass rounded-3xl overflow-hidden">
                    <div className="grid lg:grid-cols-2 gap-0">
                        {/* Left — text */}
                        <motion.div
                            initial={{ opacity: 0, x: -24 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.6 }}
                            className="p-10 md:p-14 flex flex-col justify-center"
                        >
                            <span className="badge mb-6 inline-flex">Privacy first</span>
                            <h2 className="text-3xl md:text-4xl font-bold tracking-tight mb-5">
                                Your clipboard is{' '}
                                <span className="gradient-text">your business.</span>
                            </h2>
                            <p className="text-slate-400 leading-relaxed mb-8">
                                We built ClipStruct with one rule: no data ever leaves your Mac. No analytics, no crash reporters, no hidden connections. What you copy stays with you.
                            </p>
                            <div className="inline-flex items-center gap-2 text-sm text-green-400 font-medium">
                                <div className="w-2 h-2 rounded-full bg-green-400 animate-pulse" />
                                Verified: Zero outbound network calls
                            </div>
                        </motion.div>

                        {/* Right — pillars */}
                        <motion.div
                            initial={{ opacity: 0, x: 24 }}
                            whileInView={{ opacity: 1, x: 0 }}
                            viewport={{ once: true }}
                            transition={{ duration: 0.6, delay: 0.1 }}
                            className="border-l border-white/[0.06] grid grid-cols-1 divide-y divide-white/[0.06]"
                        >
                            {pillars.map(p => (
                                <div key={p.title} className="flex items-start gap-4 p-6 hover:bg-white/[0.02] transition-colors">
                                    <div className="w-9 h-9 rounded-xl bg-green-500/10 flex items-center justify-center flex-shrink-0">
                                        <p.icon size={18} className="text-green-400" />
                                    </div>
                                    <div>
                                        <h4 className="text-sm font-semibold text-white mb-1">{p.title}</h4>
                                        <p className="text-xs text-slate-400 leading-relaxed">{p.description}</p>
                                    </div>
                                </div>
                            ))}
                        </motion.div>
                    </div>
                </div>
            </div>
        </section>
    )
}
