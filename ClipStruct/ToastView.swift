import SwiftUI

struct ToastView: View {
    let message: String
    let isVisible: Bool
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)
                .font(.system(size: 16, weight: .medium))
            
            Text(message)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(.primary)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(.regularMaterial)
                .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
        )
        .scaleEffect(isVisible ? 1.0 : 0.8)
        .opacity(isVisible ? 1.0 : 0.0)
        .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isVisible)
    }
}

struct ToastModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
            
            if isShowing {
                VStack {
                    Spacer()
                    ToastView(message: message, isVisible: isShowing)
                    Spacer().frame(height: 50)
                }
                .transition(.move(edge: .bottom).combined(with: .opacity))
            }
        }
    }
}

extension View {
    func toast(message: String, isShowing: Binding<Bool>) -> some View {
        modifier(ToastModifier(isShowing: isShowing, message: message))
    }
}
