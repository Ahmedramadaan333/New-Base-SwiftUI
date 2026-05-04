import SwiftUI

struct AlertOverlayModifier: ViewModifier {
    @EnvironmentObject var alertCenter: AlertCenter
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top, spacing: 0) {
                if let alert = alertCenter.currentAlert {
                    AppAlertBanner(alert: alert) {
                        alertCenter.dismiss()
                    }
                    .transition(
                        .move(edge: .top)
                            .combined(with: .opacity)
                    )
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                }
            }
    }
}

extension View {
    func globalAlertOverlay() -> some View {
        self.modifier(AlertOverlayModifier())
    }
}
