'use client'

import { motion } from 'framer-motion'
import {
    LuClipboard,
    LuSearch,
    LuKeyboard,
    LuShield,
    LuZap,
    LuMonitor,
    LuClock,
    LuSettings,
    LuEye
} from 'react-icons/lu'

const features = [
    {
        icon: LuClipboard,
        title: '100 Item History',
        description: 'Never lose important clipboard content with automatic history tracking up to 100 items.'
    },
    {
        icon: LuSearch,
        title: 'Lightning Fast Search',
        description: 'Find any clipboard item instantly with fuzzy search. Auto-focus for seamless workflow.'
    },
    {
        icon: LuKeyboard,
        title: 'Global Hotkeys',
        description: 'Use ⌘1-⌘9 to copy your most recent items without even opening the app.'
    },
    {
        icon: LuShield,
        title: '100% Private',
        description: 'All data stays on your Mac. No network access, no tracking, no data collection.'
    },
    {
        icon: LuZap,
        title: 'Smart Deduplication',
        description: 'Automatically handles duplicate content intelligently, keeping your history clean.'
    },
    {
        icon: LuMonitor,
        title: 'Menu Bar Integration',
        description: 'Lives quietly in your menu bar with visual feedback and status indicators.'
    },
    {
        icon: LuClock,
        title: 'Auto-Launch',
        description: 'Starts automatically when you log in. Can be easily disabled in preferences.'
    },
    {
        icon: LuSettings,
        title: 'Customizable Shortcuts',
        description: 'Modify keyboard shortcuts to fit your workflow perfectly.'
    },
    {
        icon: LuEye,
        title: 'Dark/Light Mode',
        description: 'Seamlessly adapts to your system appearance preferences.'
    }
]

export default function Features() {
    return (
        <section id="features" className="py-20 relative">
            <div className="container mx-auto px-6">
                <motion.div
                    initial={{ opacity: 0, y: 20 }}
                    whileInView={{ opacity: 1, y: 0 }}
                    transition={{ duration: 0.8 }}
                    viewport={{ once: true }}
                    className="text-center mb-16"
                >
                    <h2 className="text-4xl md:text-5xl font-bold mb-6">
                        Powerful Features for{' '}
                        <span className="gradient-text">Power Users</span>
                    </h2>
                    <p className="text-xl text-slate-300 max-w-3xl mx-auto">
                        ClipStruct is packed with features designed to supercharge your productivity
                        while keeping your data private and secure.
                    </p>
                </motion.div>

                <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
                    {features.map((feature, index) => (
                        <motion.div
                            key={feature.title}
                            initial={{ opacity: 0, y: 20 }}
                            whileInView={{ opacity: 1, y: 0 }}
                            transition={{ duration: 0.6, delay: index * 0.1 }}
                            viewport={{ once: true }}
                            className="glass-effect rounded-xl p-6 hover:bg-white/20 transition-all duration-300 group"
                        >
                            <feature.icon className="w-12 h-12 text-primary-400 mb-4 group-hover:scale-110 transition-transform duration-300" />
                            <h3 className="text-xl font-semibold mb-3">{feature.title}</h3>
                            <p className="text-slate-400 leading-relaxed">{feature.description}</p>
                        </motion.div>
                    ))}
                </div>
            </div>
        </section>
    )
}
