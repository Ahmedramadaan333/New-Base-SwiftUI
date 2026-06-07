//
//  FormField.swift
//  BaseSwiftUI
//

import SwiftUI
import Combine

/// A self-contained field that owns its value, error state, and live-validation logic.
///
/// Usage — one line per field in the ViewModel:
/// ```swift
/// let nameField = FormField { try AuthValidationService.validate(name: $0) }
/// ```
final class FormField: ObservableObject {

    // MARK: - Published State

    @Published var value: String = ""
    @Published private(set) var error: String = ""

    var hasError: Bool { !error.isEmpty }

    // MARK: - SwiftUI Binding

    /// Pass this to any text-field component instead of `$viewModel.someString`.
    var binding: Binding<String> {
        Binding(get: { self.value }, set: { self.value = $0 })
    }

    // MARK: - Private

    private let rule: (String) throws -> Void
    private let silentOnEmpty: Bool
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    /// - Parameters:
    ///   - silentOnEmpty: When `true` (default), no error is shown while the field is still empty.
    ///                    This prevents red errors appearing before the user has typed anything.
    ///   - rule: A throwing closure that maps to `AuthValidationService.validate(...)`.
    ///           Throw `AuthValidationError` to produce a localized error string.
    init(silentOnEmpty: Bool = true, rule: @escaping (String) throws -> Void) {
        self.silentOnEmpty = silentOnEmpty
        self.rule = rule
        bindLiveValidation()
    }

    // MARK: - Submit Validation

    /// Runs validation once without the silentOnEmpty guard.
    /// Call this on submit for every required field.
    /// - Returns: `true` when the field passes validation.
    @discardableResult
    func forceValidate() -> Bool {
        do {
            try rule(value)
            error = ""
            return true
        } catch let e as AuthValidationError {
            error = e.localizedDescription ?? ""
            return false
        } catch {
            self.error = error.localizedDescription
            return false
        }
    }

    // MARK: - Private helpers

    private func bindLiveValidation() {
        $value
            .dropFirst()                        // skip the initial empty value on init
            .receive(on: DispatchQueue.main)
            .sink { [weak self] newValue in
                guard let self else { return }
                if silentOnEmpty && newValue.isEmpty {
                    error = ""
                    return
                }
                do {
                    try rule(newValue)
                    error = ""
                } catch let e as AuthValidationError {
                    error = e.localizedDescription ?? ""
                } catch {
                    self.error = error.localizedDescription
                }
            }
            .store(in: &cancellables)
    }
}
