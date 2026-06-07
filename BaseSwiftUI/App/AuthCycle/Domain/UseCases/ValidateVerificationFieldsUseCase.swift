//
//  ValidateVerificationFieldsUseCase.swift
//  BaseSwiftUI
//

import Foundation

/// Domain use case that owns validation for the verification-code field.
///
/// The code field has no live validation (it is assembled digit-by-digit in the View
/// and set on submit), so only a throwing `validate` method is needed.
final class ValidateVerificationFieldsUseCase {

    /// Validates the OTP code and returns the trimmed value on success.
    /// Throws `AuthValidationError` on failure.
    @discardableResult
    func validate(code: String) throws -> String {
        return try AuthValidationService.validate(verificationCode: code)
    }
}
