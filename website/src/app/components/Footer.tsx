'use client'

import Link from 'next/link'
import { LuGithub, LuHeart, LuTwitter, LuMail } from 'react-icons/lu'
import Image from "next/image";

export default function Footer() {
    return (
        <footer className="bg-slate-900/80 border-t border-white/10 py-12">
            <div className="container mx-auto px-6">
                <div className="grid grid-cols-1 md:grid-cols-4 gap-8">
                    {/* Brand */}
                    <div>
                        <div className="flex items-center space-x-2 mb-4">
                            <div className="w-8 h-8 ">
                                <Image src="/icon.png" width={100} height={100} alt="Clip Struct" />
                            </div>
                            <span className="text-xl font-bold">ClipStruct</span>
                        </div>
                        <p className="text-slate-400 text-sm leading-relaxed">
                            The ultimate clipboard manager for macOS. Built with privacy and productivity in mind.
                        </p>
                    </div>

                    {/* Product */}
                    <div>
                        <h4 className="font-semibold mb-4">Product</h4>
                        <ul className="space-y-2 text-sm text-slate-400">
                            <li><Link href="#features" className="hover:text-white transition-colors">Features</Link></li>
                            <li><Link href="#download" className="hover:text-white transition-colors">Download</Link></li>
                            <li><Link href="#" className="hover:text-white transition-colors">Release Notes</Link></li>
                            <li><Link href="#" className="hover:text-white transition-colors">System Requirements</Link></li>
                        </ul>
                    </div>

                    {/* Support */}
                    <div>
                        <h4 className="font-semibold mb-4">Support</h4>
                        <ul className="space-y-2 text-sm text-slate-400">
                            <li><Link href="https://github.com/HeyShinde/ClipStruct/issues" className="hover:text-white transition-colors">Bug Reports</Link></li>
                            <li><Link href="https://github.com/HeyShinde/ClipStruct/discussions" className="hover:text-white transition-colors">Feature Requests</Link></li>
                            <li><Link href="#" className="hover:text-white transition-colors">Privacy Policy</Link></li>
                            <li><Link href="#" className="hover:text-white transition-colors">Terms of Service</Link></li>
                        </ul>
                    </div>

                    {/* Connect */}
                    <div>
                        <h4 className="font-semibold mb-4">Connect</h4>
                        <ul className="space-y-2 text-sm text-slate-400">
                            <li>
                                <Link href="https://github.com/HeyShinde/ClipStruct" className="hover:text-white transition-colors flex items-center space-x-2">
                                    <LuGithub size={16} />
                                    <span>GitHub</span>
                                </Link>
                            </li>
                            <li>
                                <Link href="https://github.com/sponsors/HeyShinde" className="hover:text-white transition-colors flex items-center space-x-2">
                                    <LuHeart size={16} />
                                    <span>Sponsor</span>
                                </Link>
                            </li>
                            <li>
                                <Link href="https://twitter.com/HeyShinde" className="hover:text-white transition-colors flex items-center space-x-2">
                                    <LuTwitter size={16} />
                                    <span>Twitter</span>
                                </Link>
                            </li>
                            <li>
                                <Link href="mailto:clipstruct@heyshinde.com" className="hover:text-white transition-colors flex items-center space-x-2">
                                    <LuMail size={16} />
                                    <span>Email</span>
                                </Link>
                            </li>
                        </ul>
                    </div>
                </div>

                <div className="border-t border-white/10 mt-12 pt-8 flex flex-col md:flex-row items-center justify-between">
                    <p className="text-slate-400 text-sm">
                        © 2025 ClipStruct <Link className="text-blue-400" href={"https://www.heyshinde.com"}>(HeyShinde)</Link>. Made with ❤️ for the macOS community.
                    </p>
                    <p className="text-slate-400 text-sm mt-4 md:mt-0">
                        All data stays on your Mac. Privacy first, always.
                    </p>
                </div>
            </div>
        </footer>
    )
}
