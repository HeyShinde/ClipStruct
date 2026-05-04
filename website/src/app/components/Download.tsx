'use client'

import { motion } from 'framer-motion'
import { LuDownload, LuGithub, LuExternalLink, LuCircleAlert } from 'react-icons/lu'
import Link from 'next/link'
import Image from 'next/image'

export default function DownloadSection() {
    return (
        <section id="download" className="py-20 bg-gradient-to-r from-slate-800/50 to-blue-900/50">
            <div className="container mx-auto px-6">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                    viewport={{ once: true }}
                    className="text-center mb-12"
                >
                    <h2 className="text-4xl md:text-5xl font-bold mb-6">
                        Ready to <span className="gradient-text">Supercharge</span> Your Workflow?
                    </h2>
                    <p className="text-xl text-slate-300 max-w-2xl mx-auto">
                        Download ClipStruct today and never lose important clipboard content again.
                    </p>
                </motion.div>

                <div className="max-w-4xl mx-auto">
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.2 }}
                        viewport={{ once: true }}
                        className="glass-effect rounded-2xl p-8 mb-8"
                    >
                        <div className="flex flex-col lg:flex-row items-center justify-between">
                            <div className="flex items-center space-x-4 mb-6 lg:mb-0">
                                    <Image src="/icon.png" width={100} height={100} alt="Clip Struct" />
                                <div>
                                    <h3 className="text-2xl font-bold">ClipStruct v1.0.0</h3>
                                    <p className="text-slate-400">For macOS 15.0 (Sonoma) and later</p>
                                    <p className="text-sm text-primary-400">Free • 5.6 MB • Universal Binary</p>
                                </div>
                            </div>

                            <div className="flex flex-col sm:flex-row space-y-3 sm:space-y-0 sm:space-x-4">
                                <Link
                                    href="https://github.com/HeyShinde/ClipStruct/releases/download/v1.0.0/ClipStruct-1.0.0.dmg"
                                    className="btn-primary flex items-center space-x-2"
                                >
                                    <LuDownload size={20} />
                                    <span>Download DMG</span>
                                </Link>
                                <Link
                                    href="https://github.com/HeyShinde/ClipStruct/releases/tag/v1.0.0"
                                    className="btn-secondary flex items-center space-x-2"
                                >
                                    <LuGithub size={20} />
                                    <span>View Release</span>
                                </Link>
                            </div>
                        </div>
                    </motion.div>

                    {/* Installation Instructions */}
                    <motion.div
                        initial={{ opacity: 0, y: 20 }}
                        whileInView={{ opacity: 1, y: 0 }}
                        transition={{ duration: 0.8, delay: 0.4 }}
                        viewport={{ once: true }}
                        className="grid md:grid-cols-2 gap-8"
                    >
                        <div className="glass-effect rounded-xl p-6">
                            <h4 className="text-lg font-semibold mb-4 flex items-center space-x-2">
                                <LuDownload className="w-5 h-5 text-primary-400" />
                                <span>Installation Steps</span>
                            </h4>
                            <ol className="space-y-3 text-slate-300">
                                <li className="flex items-start space-x-3">
                                    <span className="bg-primary-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold flex-shrink-0 mt-0.5">1</span>
                                    <span>Download ClipStruct-1.0.0.dmg</span>
                                </li>
                                <li className="flex items-start space-x-3">
                                    <span className="bg-primary-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold flex-shrink-0 mt-0.5">2</span>
                                    <span>Open the DMG file</span>
                                </li>
                                <li className="flex items-start space-x-3">
                                    <span className="bg-primary-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold flex-shrink-0 mt-0.5">3</span>
                                    <span>Drag ClipStruct to Applications folder</span>
                                </li>
                                <li className="flex items-start space-x-3">
                                    <span className="bg-primary-500 text-white rounded-full w-6 h-6 flex items-center justify-center text-sm font-bold flex-shrink-0 mt-0.5">4</span>
                                    <span>Launch and grant permissions</span>
                                </li>
                            </ol>
                        </div>

                        <div className="glass-effect rounded-xl p-6">
                            <h4 className="text-lg font-semibold mb-4 flex items-center space-x-2">
                                <LuCircleAlert className="w-5 h-5 text-yellow-400" />
                                <span>Security Notice</span>
                            </h4>
                            <div className="space-y-3 text-slate-300">
                                <p className="text-sm">
                                    ClipStruct is not notarized by Apple since we&apos;re an independent developer.
                                    This is completely safe and normal for indie apps.
                                </p>
                                <p className="text-sm">
                                    On first launch, right-click the app and select &quot;Open&quot;, or go to
                                    System Preferences → Security &amp; Privacy → &quot;Open Anyway&quot;.
                                </p>
                                <Link
                                    href="#"
                                    className="text-primary-400 hover:text-primary-300 text-sm flex items-center space-x-1"
                                >
                                    <span>Learn more about app security</span>
                                    <LuExternalLink size={14} />
                                </Link>
                            </div>
                        </div>
                    </motion.div>
                </div>
            </div>
        </section>
    )
}
