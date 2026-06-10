//
//  BaseScreen.swift
//  CTF
//
//  Created by Ahmed Ramadan on 19/11/2025.
//

import SwiftUI

struct BaseView<Content: View>: View {
    let title: String
    let background: Color
    let showNavigationBar: Bool
    let contentPadding: EdgeInsets
    let content: () -> Content

    init(
        title: String,
        background: Color = .backgroundView,
        showNavigationBar: Bool = true,
        contentPadding: EdgeInsets = EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16),
        @ViewBuilder content: @escaping () -> Content
    ) {
        self.title = title
        self.background = background
        self.showNavigationBar = showNavigationBar
        self.contentPadding = contentPadding
        self.content = content
    }

    var body: some View {
        let view = content()
            .padding(contentPadding)
            .background(background)

        if showNavigationBar {
            view.appNavigationBar(title)
        } else {
            view
        }
    }
}

extension View {
    func applyLayoutDirection() -> some View {
        self.environment(\.layoutDirection, AppLanguageManager.isRTL() ? .rightToLeft : .leftToRight)
    }
}

extension View {
    @ViewBuilder
    func iPad<Content: View>(_ transform: (Self) -> Content) -> some View {
        let isTablet = UIDevice.current.userInterfaceIdiom == .pad
        
        if isTablet {
            transform(self)
        } else {
            self
        }
    }
    
    @ViewBuilder
    func iPhone<Content: View>(_ transform: (Self) -> Content) -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            transform(self)
        } else {
            self
        }
    }
}


extension View {
    func applyLinearGradientOverlay() -> some View {
        self.overlay(
            LinearGradient(
                gradient: Gradient(colors: [
                    Color.white.opacity(0.0),
                    Color.black.opacity(0.38),
                    Color.black.opacity(0.62),
                    Color.black.opacity(0.94)
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(8)
            .opacity(0.8)
        )
    }
}


extension View {
    func hideScrollIndicators() -> some View {
        if #available(iOS 16.0, *) {
            return AnyView(self.scrollIndicators(.hidden))
        } else {
            return Group{}
        }
    }
}


extension View {
    func roundedMasked(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension View {
    func endEditing() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: Bool, transform: (Self) -> Content) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
}
//MARK: - Usage -
/*
 struct ContentView: View {
     
     private var shouldApplyBackground: Bool {
         guard #available(iOS 14, *) else {
             return true
         }
         return false
     }
     
     var body: some View {
         Text("Hello, world!")
             .padding()
             .if(shouldApplyBackground) { view in
                 // We only apply this background color if shouldApplyBackground is true
                 view.background(Color.red)
             }
     }
 }
 */

extension View {
    /// Applies the given transform if the given condition evaluates to `true`.
    /// - Parameters:
    ///   - condition: The condition to evaluate.
    ///   - transform: The transform to apply to the source `View`.
    /// - Returns: Either the original `View` or the modified `View` if the condition is `true`.
    @ViewBuilder func `if`<Content: View>(_ condition: @autoclosure () -> Bool, transform: (Self) -> Content) -> some View {
        if condition() {
            transform(self)
        } else {
            self
        }
    }
}
//MARK: - Usage -
/*
 struct ContentView: View {
      var body: some View {
          Text("Hello, world!")
              .padding()
              .if({
                  if #available(iOS 14, *) {
                      return true
                  }
                  return false
              }()) { view in
                  view.background(Color.red)
              }
      }
  }
 */

extension Bool {
     static var iOS17: Bool {
         guard #available(iOS 17, *) else {
             // It's iOS 13 so return true.
             return true
         }
         // It's iOS 14 so return false.
         return false
     }
    
    static var iOS18: Bool {
        guard #available(iOS 18, *) else {
            // It's iOS 13 so return true.
            return true
        }
        // It's iOS 14 so return false.
        return false
    }
 }
//MARK: - Usage -
/*
 struct ContentView: View {
     
     var body: some View {
         Text("Hello, world!")
 
             
             .if(.iOS17) { view in
                 view.background(Color.red)
             }
     }
 }
 */
