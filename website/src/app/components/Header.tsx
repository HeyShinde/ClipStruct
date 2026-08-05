'use client'

import { useState, useEffect } from 'react'
import { motion, AnimatePresence } from 'framer-motion'
import { LuGithub, LuHeart, LuMenu, LuX } from 'react-icons/lu'
import Link from 'next/link'
import Image from 'next/image'

const navLinks = [
    { label: 'Features', href: '#features' },
    { label: 'Download', href: '#download' },
    { label: 'Privacy', href: '#privacy' },
]

export default function Header() {
    const [isScrolled, setIsScrolled] = useState(false)
    const [isMenuOpen, setIsMenuOpen] = useState(false)

    useEffect(() => {
        const handler = () => setIsScrolled(window.scrollY > 24)
        window.addEventListener('scroll', handler, { passive: true })
        return () => window.removeEventListener('scroll', handler)
    }, [])

    return (
        <header
            className={`fixed top-0 inset-x-0 z-50 transition-all duration-500 ${
                isScrolled
                    ? 'bg-[#050508]/80 backdrop-blur-xl border-b border-white/[0.06]'
                    : 'bg-transparent'
            }`}
        >
            <div className="max-w-6xl mx-auto px-6">
                <nav className="flex items-center justify-between h-16">
                    {/* Logo */}
                    <Link href="/" className="flex items-center gap-2.5 group">
                        <div className="w-8 h-8 rounded-lg overflow-hidden ring-1 ring-white/10 group-hover:ring-violet-500/40 transition-all">
                            <Image src="/icon.png" width={32} height={32} alt="ClipStruct" className="w-full h-full object-cover" />
                        </div>
                        <span className="font-bold text-white text-[17px] tracking-tight">ClipStruct</span>
                    </Link>

                    {/* Desktop nav */}
                    <div className="hidden md:flex items-center gap-8">
                        {navLinks.map(link => (
                            <Link
                                key={link.label}
                                href={link.href}
                                className="text-sm text-slate-400 hover:text-white transition-colors duration-200"
                            >
                                {link.label}
                            </Link>
                        ))}
                    </div>

                    {/* Desktop actions */}
                    <div className="hidden md:flex items-center gap-3">
                        <Link
                            href="https://github.com/HeyShinde/ClipStruct"
                            target="_blank"
                            className="btn-ghost flex items-center gap-2 !py-2 !px-4 text-sm"
                        >
                            <LuGithub size={16} />
                            <span>GitHub</span>
                        </Link>
                        <Link
                            href="https://github.com/sponsors/HeyShinde"
                            target="_blank"
                            className="btn-primary flex items-center gap-2 !py-2 !px-4 text-sm"
                        >
                            <LuHeart size={14} />
                            <span>Sponsor</span>
                        </Link>
                    </div>

                    {/* Mobile toggle */}
                    <button
                        className="md:hidden text-slate-400 hover:text-white transition-colors p-1"
                        onClick={() => setIsMenuOpen(!isMenuOpen)}
                        aria-label="Toggle menu"
                    >
                        {isMenuOpen ? <LuX size={22} /> : <LuMenu size={22} />}
                    </button>
                </nav>
            </div>

            {/* Mobile menu */}
            <AnimatePresence>
                {isMenuOpen && (
                    <motion.div
                        initial={{ opacity: 0, height: 0 }}
                        animate={{ opacity: 1, height: 'auto' }}
                        exit={{ opacity: 0, height: 0 }}
                        transition={{ duration: 0.2 }}
                        className="md:hidden bg-[#0d0d14]/95 backdrop-blur-xl border-b border-white/[0.06]"
                    >
                        <div className="max-w-6xl mx-auto px-6 py-4 flex flex-col gap-4">
                            {navLinks.map(link => (
                                <Link
                                    key={link.label}
                                    href={link.href}
                                    className="text-slate-300 hover:text-white text-sm py-1"
                                    onClick={() => setIsMenuOpen(false)}
                                >
                                    {link.label}
                                </Link>
                            ))}
                            <div className="flex gap-3 pt-2 border-t border-white/[0.06]">
                                <Link href="https://github.com/HeyShinde/ClipStruct" target="_blank" className="btn-ghost flex items-center gap-2 !py-2 !px-4 text-sm flex-1 justify-center">
                                    <LuGithub size={16} /><span>GitHub</span>
                                </Link>
                                <Link href="https://github.com/sponsors/HeyShinde" target="_blank" className="btn-primary flex items-center gap-2 !py-2 !px-4 text-sm flex-1 justify-center">
                                    <LuHeart size={14} /><span>Sponsor</span>
                                </Link>
                            </div>
                        </div>
                    </motion.div>
                )}
            </AnimatePresence>
        </header>
    )
}
