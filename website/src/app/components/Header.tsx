'use client'

import { useState, useEffect } from 'react'
import { LuMenu, LuX, LuGithub, LuHeart } from 'react-icons/lu'
import Link from 'next/link'
import Image from "next/image";

export default function Header() {
    const [isMenuOpen, setIsMenuOpen] = useState(false)
    const [isScrolled, setIsScrolled] = useState(false)

    useEffect(() => {
        const handleScroll = () => {
            setIsScrolled(window.scrollY > 20)
        }
        window.addEventListener('scroll', handleScroll)
        return () => window.removeEventListener('scroll', handleScroll)
    }, [])

    return (
        <header className={`fixed w-full z-50 transition-all duration-300 ${
            isScrolled ? 'glass-effect shadow-lg' : 'bg-transparent'
        }`}>
            <nav className="container mx-auto px-6 py-4">
                <div className="flex items-center justify-between">
                    <div className="flex items-center space-x-2">
                            <Image src="/icon.png" width={100} height={100} alt="Clip Struct" />
                        <span className="text-xl font-bold">ClipStruct</span>
                    </div>

                    {/* Desktop Navigation */}
                    <div className="hidden md:flex items-center space-x-8">
                        <Link href="#features" className="hover:text-primary-400 transition-colors">
                            Features
                        </Link>
                        <Link href="#download" className="hover:text-primary-400 transition-colors">
                            Download
                        </Link>
                        <Link href="https://github.com/HeyShinde/ClipStruct" className="hover:text-primary-400 transition-colors flex items-center space-x-1">
                            <LuGithub size={18} />
                            <span>GitHub</span>
                        </Link>
                        <Link href="https://github.com/sponsors/HeyShinde" className="btn-secondary flex items-center space-x-2">
                            <LuHeart size={18} />
                            <span>Sponsor</span>
                        </Link>
                    </div>

                    {/* Mobile Menu Button */}
                    <button
                        className="md:hidden"
                        onClick={() => setIsMenuOpen(!isMenuOpen)}
                    >
                        {isMenuOpen ? <LuX size={24} /> : <LuMenu size={24} />}
                    </button>
                </div>

                {/* Mobile Navigation */}
                {isMenuOpen && (
                    <div className="md:hidden mt-4 pb-4 border-t border-white/20">
                        <div className="flex flex-col space-y-4 mt-4">
                            <Link href="#features" className="hover:text-primary-400 transition-colors">
                                Features
                            </Link>
                            <Link href="#download" className="hover:text-primary-400 transition-colors">
                                Download
                            </Link>
                            <Link href="https://github.com/HeyShinde/ClipStruct" className="hover:text-primary-400 transition-colors flex items-center space-x-1">
                                <LuGithub size={18} />
                                <span>GitHub</span>
                            </Link>
                            <Link href="https://github.com/sponsors/HeyShinde" className="btn-secondary inline-flex items-center space-x-2 justify-center">
                                <LuHeart size={18} />
                                <span>Sponsor</span>
                            </Link>
                        </div>
                    </div>
                )}
            </nav>
        </header>
    )
}
