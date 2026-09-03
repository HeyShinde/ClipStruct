import { ImageResponse } from 'next/og'

export const runtime = 'edge'
export const alt = 'ClipStruct — Premium macOS Clipboard Manager'
export const size = {
    width: 1200,
    height: 630,
}
export const contentType = 'image/png'

export default async function Image() {
    return new ImageResponse(
        (
            <div
                style={{
                    height: '100%',
                    width: '100%',
                    display: 'flex',
                    flexDirection: 'column',
                    alignItems: 'center',
                    justifyContent: 'center',
                    backgroundColor: '#050508',
                    backgroundImage: 'radial-gradient(circle at 50% 30%, rgba(139, 92, 246, 0.25) 0%, transparent 70%)',
                    fontFamily: 'system-ui, sans-serif',
                    color: '#f8fafc',
                    padding: '60px 80px',
                    textAlign: 'center',
                }}
            >
                <div
                    style={{
                        display: 'flex',
                        alignItems: 'center',
                        justifyContent: 'center',
                        width: 96,
                        height: 96,
                        borderRadius: 24,
                        background: 'linear-gradient(135deg, #8b5cf6, #6366f1)',
                        boxShadow: '0 0 40px rgba(139, 92, 246, 0.6)',
                        marginBottom: 32,
                        fontSize: 48,
                    }}
                >
                    📋
                </div>
                <div
                    style={{
                        fontSize: 64,
                        fontWeight: 800,
                        letterSpacing: '-0.03em',
                        marginBottom: 16,
                        background: 'linear-gradient(135deg, #f8fafc, #c4b5fd)',
                        backgroundClip: 'text',
                        color: 'transparent',
                    }}
                >
                    ClipStruct
                </div>
                <div
                    style={{
                        fontSize: 28,
                        color: '#94a3b8',
                        maxWidth: 800,
                        lineHeight: 1.4,
                        marginBottom: 40,
                    }}
                >
                    The most intelligent, native clipboard manager for macOS.
                    Lightning-fast search, smart structuring & complete privacy.
                </div>
                <div
                    style={{
                        display: 'flex',
                        gap: 16,
                        alignItems: 'center',
                    }}
                >
                    <div
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: 8,
                            padding: '10px 24px',
                            borderRadius: 999,
                            background: 'rgba(139, 92, 246, 0.15)',
                            border: '1px solid rgba(139, 92, 246, 0.4)',
                            color: '#c4b5fd',
                            fontSize: 18,
                            fontWeight: 600,
                        }}
                    >
                         macOS 14.0+
                    </div>
                    <div
                        style={{
                            display: 'flex',
                            alignItems: 'center',
                            gap: 8,
                            padding: '10px 24px',
                            borderRadius: 999,
                            background: 'rgba(255, 255, 255, 0.05)',
                            border: '1px solid rgba(255, 255, 255, 0.1)',
                            color: '#f8fafc',
                            fontSize: 18,
                            fontWeight: 600,
                        }}
                    >
                        100% Free & On-Device
                    </div>
                </div>
            </div>
        ),
        {
            ...size,
        }
    )
}
