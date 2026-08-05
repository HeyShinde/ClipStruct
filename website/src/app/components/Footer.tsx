'use client'

import Link from 'next/link'
import Image from 'next/image'
import { LuGithub, LuHeart, LuTwitter, LuMail, LuArrowUpRight } from 'react-icons/lu'

const links = {
    Product: [
        { label: 'Features', href: '#features' },
        { label: 'Download', href: '#download' },
        { label: 'Privacy', href: '#privacy' },
        { label: 'Release Notes', href: 'https://github.com/HeyShinde/ClipStruct/releases' },
    ],
    Support: [
        { label: 'Bug Reports', href: 'https://github.com/HeyShinde/ClipStruct/issues', external: true },
        { label: 'Feature Requests', href: 'https://github.com/HeyShinde/ClipStruct/discussions', external: true },
        { label: 'Source Code', href: 'https://github.com/HeyShinde/ClipStruct', external: true },
    ],
}

const socials = [
    { icon: LuGithub, label: 'GitHub', href: 'https://github.com/HeyShinde/ClipStruct' },
    { icon: LuHeart, label: 'Sponsor', href: 'https://github.com/sponsors/HeyShinde' },
    { icon: LuTwitter, label: 'Twitter', href: 'https://twitter.com/HeyShinde' },
    { icon: LuMail, label: 'Email', href: 'mailto:clipstruct@heyshinde.com' },
]

export default function Footer() {
    return (
        <footer className="border-t border-white/[0.06] mt-20">
            <div className="max-w-6xl mx-auto px-6 pt-16 pb-10">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-12 mb-16">
                    {/* Brand column */}
                    <div className="md:col-span-1">
                        <Link href="/" className="flex items-center gap-2.5 mb-4 group w-fit">
                            <div className="w-8 h-8 rounded-lg overflow-hidden ring-1 ring-white/10">
                                <Image src="/icon.png" width={32} height={32} alt="ClipStruct" className="w-full h-full object-cover" />
                            </div>
                            <span className="font-bold text-white">ClipStruct</span>
                        </Link>
                        <p className="text-sm text-slate-500 leading-relaxed mb-6">
                            The premium macOS clipboard manager. Built by an indie developer, for power users.
                        </p>
                        {/* Social icons */}
                        <div className="flex items-center gap-3">
                            {socials.map(s => (
                                <Link
                                    key={s.label}
                                    href={s.href}
                                    target="_blank"
                                    aria-label={s.label}
                                    className="w-8 h-8 rounded-lg bg-white/[0.04] border border-white/[0.07] flex items-center justify-center text-slate-500 hover:text-white hover:bg-white/[0.08] hover:border-violet-500/30 transition-all"
                                >
                                    <s.icon size={15} />
                                </Link>
                            ))}
                        </div>
                    </div>

                    {/* Link columns */}
                    {Object.entries(links).map(([category, items]) => (
                        <div key={category}>
                            <h4 className="text-xs font-semibold text-slate-300 uppercase tracking-widest mb-5">{category}</h4>
                            <ul className="flex flex-col gap-3">
                                {items.map(item => (
                                    <li key={item.label}>
                                        <Link
                                            href={item.href}
                                            target={'external' in item && item.external ? '_blank' : undefined}
                                            className="text-sm text-slate-500 hover:text-white transition-colors flex items-center gap-1 group"
                                        >
                                            {item.label}
                                            {'external' in item && item.external && (
                                                <LuArrowUpRight size={12} className="opacity-0 group-hover:opacity-100 transition-opacity" />
                                            )}
                                        </Link>
                                    </li>
                                ))}
                            </ul>
                        </div>
                    ))}

                    {/* Sponsor CTA */}
                    <div>
                        <h4 className="text-xs font-semibold text-slate-300 uppercase tracking-widest mb-5">Support the project</h4>
                        <p className="text-sm text-slate-500 mb-4">ClipStruct is free forever. If it saves you time, consider supporting development.</p>
                        <Link
                            href="https://buymeacoffee.com/heyshinde"
                            target="_blank"
                            className="btn-ghost inline-flex items-center gap-2 text-sm !py-2 !px-4"
                        >
                            <LuHeart size={14} className="text-pink-400" />
                            Buy me a coffee
                        </Link>
                    </div>
                </div>

                {/* Divider */}
                <div className="divider mb-8" />

                {/* Bottom bar */}
                <div className="flex flex-col md:flex-row items-center justify-between gap-4">
                    <p className="text-xs text-slate-600">
                        © 2026 ClipStruct by{' '}
                        <Link href="https://heyshinde.com" target="_blank" className="hover:text-slate-400 transition-colors">
                            HeyShinde
                        </Link>
                        . Made with ❤️ for the macOS community.
                    </p>
                    <p className="text-xs text-slate-700">
                        All data stays on your Mac. Privacy first, always.
                    </p>
                </div>
            </div>
        </footer>
    )
}
