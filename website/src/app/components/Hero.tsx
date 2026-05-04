'use client'

import { motion } from 'framer-motion'
import { LuDownload, LuCommand, LuSearch, LuZap, LuGithub } from 'react-icons/lu'
import Link from 'next/link'

export default function Hero() {
    return (
        <section className="relative min-h-screen flex items-center justify-center pt-20">
            {/* Background Elements */}
            <div className="absolute inset-0 overflow-hidden">
                <div className="absolute -top-40 -right-40 w-80 h-80 bg-primary-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse"></div>
                <div className="absolute -bottom-40 -left-40 w-80 h-80 bg-purple-500 rounded-full mix-blend-multiply filter blur-xl opacity-20 animate-pulse animation-delay-2000"></div>
            </div>

            <div className="container mx-auto px-6 relative z-10">
                <div className="text-center max-w-4xl mx-auto">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8 }}
                    >
                        <h1 className="text-5xl md:text-7xl font-bold mb-6 leading-tight">
                            The Ultimate{' '}
                            <span className="gradient-text">Clipboard Manager</span>{' '}
                            for macOS
                        </h1>
                    </motion.div>

                    <motion.p
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.2 }}
                        className="text-xl md:text-2xl text-slate-300 mb-8 leading-relaxed"
                    >
                        Never lose important clipboard content again. Store 100+ items,
                        use lightning-fast search, and access everything with global hotkeys.
                    </motion.p>

                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.4 }}
                        className="flex flex-col sm:flex-row items-center justify-center space-y-4 sm:space-y-0 sm:space-x-6 mb-12"
                    >
                        <Link href="#download" className="btn-primary flex items-center space-x-2 border-2 border-blue-400 p-3 rounded-md">
                            <LuDownload size={20} />
                            <span>Download Free</span>
                        </Link>
                        <Link href="https://github.com/HeyShinde/ClipStruct" className="btn-primary flex items-center space-x-2 border-2 border-blue-400 p-3 rounded-md">
                            <LuGithub size={20} />
                            <span>View on GitHub</span>
                        </Link>
                    </motion.div>

                    {/* Quick Features */}
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        animate={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.6 }}
                        className="grid grid-cols-1 md:grid-cols-3 gap-6 max-w-3xl mx-auto"
                    >
                        <div className="glass-effect rounded-lg p-6 text-center">
                            <LuCommand className="w-8 h-8 text-primary-400 mx-auto mb-3" />
                            <h3 className="font-semibold mb-2">Global Hotkeys</h3>
                            <p className="text-sm text-slate-400">⌘1-⌘9 for instant access</p>
                        </div>
                        <div className="glass-effect rounded-lg p-6 text-center">
                            <LuSearch className="w-8 h-8 text-primary-400 mx-auto mb-3" />
                            <h3 className="font-semibold mb-2">Smart Search</h3>
                            <p className="text-sm text-slate-400">Find anything instantly</p>
                        </div>
                        <div className="glass-effect rounded-lg p-6 text-center">
                            <LuZap className="w-8 h-8 text-primary-400 mx-auto mb-3" />
                            <h3 className="font-semibold mb-2">100% Private</h3>
                            <p className="text-sm text-slate-400">All data stays on your Mac</p>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    )
}
