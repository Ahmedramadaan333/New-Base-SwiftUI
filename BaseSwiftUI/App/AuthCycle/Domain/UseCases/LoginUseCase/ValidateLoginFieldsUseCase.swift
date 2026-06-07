//
//  ValidateLoginFieldsUseCase.swift
//  BaseSwiftUI
//

import Foundation

/// Domain use case that owns all **live** (as-you-type) validation rules for the login form.
///
/// - Returns `nil`  → field is valid.
/// - Returns `String` → localized error message to show under the field.
///
/// Empty-value behaviour (silencing "please enter…" while the user hasn't typed yet)
/// is a Presentation concern and is handled by `BaseViewModel.bindField`, not here.
///
/// Submit-time (full) validation stays in `LoginUseCase.execute` as before.
final class ValidateLoginFieldsUseCase {

    func liveValidate(phone: String) -> String? {
        do {
            _ = try AuthValidationService.validate(phone: phone)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return error.localizedDescription
        }
    }

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

    func liveValidate(password: String) -> String? {
        do {
            _ = try AuthValidationService.validate(password: password)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return error.localizedDescription
        }
    }

    /// Re-validates whenever either `confirmPassword` or `password` changes.
    func liveValidate(confirmPassword: String, against password: String) -> String? {
        do {
            _ = try AuthValidationService.validate(password: password, confirmPassword: confirmPassword)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return error.localizedDescription
        }
    }
}
