//
//  FieldState.swift
//  BaseSwiftUI
//

/// Bundles the three things every form field needs into one @Published property.
///
/// Declaration (replaces three separate @Published lines):
/// ```swift
/// @Published var phone = FieldState()
/// ```
///
/// View usage — SwiftUI resolves nested bindings automatically:
/// ```swift
/// text:         $viewModel.phone.value
/// hasError:     viewModel.phone.hasError
/// errorMessage: viewModel.phone.error
/// ```
struct FieldState {
    var value: String = ""
    var error: String = ""
    var hasError: Bool { !error.isEmpty }
}
