//
//  ValidateRegisterFieldsUseCase.swift
//  BaseSwiftUI
//

import Foundation

/// Domain use case that owns all validation rules for the complete-registration form.
///
/// - `liveValidate` methods return `nil` (valid) or a localized error string.
///   Empty-value silencing is handled by `BaseViewModel.bindField`, not here.
/// - `validate` methods throw `AuthValidationError` and are called at submit time.
final class ValidateRegisterFieldsUseCase {

    // MARK: - Live (as-you-type)

    func liveValidate(name: String) -> String? {
        do {
            _ = try AuthValidationService.validate(name: name)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return error.localizedDescription
        }
    }

    /// Bool fields have no "empty" concept so no silent guard is applied.
    func liveValidate(termsAccepted: Bool) -> String? {
        do {
            try AuthValidationService.validate(termesAgreed: termsAccepted)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return error.localizedDescription
        }
    }

    // MARK: - Submit (throws)

    func validate(name: String) throws {
        _ = try AuthValidationService.validate(name: name)
    }

    func validate(termsAccepted: Bool) throws {
        try AuthValidationService.validate(termesAgreed: termsAccepted)
    }
}
