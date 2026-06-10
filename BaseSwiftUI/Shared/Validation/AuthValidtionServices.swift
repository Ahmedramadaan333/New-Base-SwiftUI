//
//  AuthValidtionServices.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 23/07/2025.
//

import Foundation


struct AuthValidationService {

    static func validate(phone: String?) throws -> String {
        guard let phone = phone, !phone.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyPhone
        }
        guard phone.count > 8 else {
            throw AuthValidationError.shortPhone
        }
        guard phone.count < 11 else {
            throw AuthValidationError.longPhone
        }

        return phone
    }
    static func validate(name: String?) throws -> String {
        guard let name = name, !name.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyName
        }
        guard name.count > 1 else {
            throw AuthValidationError.shortName
        }
        guard name.count < 18 else {
            throw AuthValidationError.longName
        }
        return name
    }
    
    static func validate(termesAgreed: Bool) throws {
        guard termesAgreed else {
            throw AuthValidationError.terms
        }
    }

    static func validate(arabicName: String?) throws -> String {
        guard let arabicName = arabicName, !arabicName.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyArabicName
        }
        guard arabicName.count > 1 else {
            throw AuthValidationError.shortArabicName
        }
        guard arabicName.count < 61 else {
            throw AuthValidationError.longArabicName
        }
        return arabicName
    }
    static func validate(englishName: String?) throws -> String {
        guard let englishName = englishName, !englishName.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyEnglishName
        }
        guard englishName.count > 1 else {
            throw AuthValidationError.shortEnglishName
        }
        guard englishName.count < 61 else {
            throw AuthValidationError.longEnglishName
        }
        return englishName
    }
    
    static func validate(password: String?) throws -> String {
        guard let password = password, !password.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyPassword
        }
        guard password.count >= 6 else {
            throw AuthValidationError.shortPassword
        }
        guard password.count <= 52 else {
            throw AuthValidationError.longPassword
        }
        
        let letterRegex = ".*[A-Za-z]+.*"
        let numberRegex = ".*[0-9]+.*"
        let symbolRegex = ".*[^A-Za-z0-9]+.*"
        let capitalLetterRegex = ".*[A-Z]+.*"
        
        if !NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: password) {
            throw AuthValidationError.missingLetter
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: password) {
            throw AuthValidationError.missingNumber
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", symbolRegex).evaluate(with: password) {
            throw AuthValidationError.missingSymbol
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex).evaluate(with: password) {
            throw AuthValidationError.missingCapitalLetter
        }
        
        return password
    }
    static func validate(oldPassword: String?) throws -> String {
        guard let oldPassword = oldPassword, !oldPassword.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyOldPassword
        }
        guard oldPassword.count >= 6 else {
            throw AuthValidationError.shortOldPassword
        }
        guard oldPassword.count <= 52 else {
            throw AuthValidationError.longPassword
        }
        
        let letterRegex = ".*[A-Za-z]+.*"
        let numberRegex = ".*[0-9]+.*"
        let symbolRegex = ".*[^A-Za-z0-9]+.*"
        let capitalLetterRegex = ".*[A-Z]+.*"
        
        if !NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: oldPassword) {
            throw AuthValidationError.missingLetter
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: oldPassword) {
            throw AuthValidationError.missingNumber
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", symbolRegex).evaluate(with: oldPassword) {
            throw AuthValidationError.missingSymbol
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex).evaluate(with: oldPassword) {
            throw AuthValidationError.missingCapitalLetter
        }
        
        return oldPassword
    }
    static func validate(newPassword: String?) throws -> String {
        guard let newPassword = newPassword, !newPassword.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyNewPassword
        }
        guard newPassword.count >= 6 else {
            throw AuthValidationError.shortNewPassword
        }
        guard newPassword.count <= 52 else {
            throw AuthValidationError.longPassword
        }
        
        let letterRegex = ".*[A-Za-z]+.*"
        let numberRegex = ".*[0-9]+.*"
        let symbolRegex = ".*[^A-Za-z0-9]+.*"
        let capitalLetterRegex = ".*[A-Z]+.*"
        
        if !NSPredicate(format: "SELF MATCHES %@", letterRegex).evaluate(with: newPassword) {
            throw AuthValidationError.missingLetter
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", numberRegex).evaluate(with: newPassword) {
            throw AuthValidationError.missingNumber
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", symbolRegex).evaluate(with: newPassword) {
            throw AuthValidationError.missingSymbol
        }
        
        if !NSPredicate(format: "SELF MATCHES %@", capitalLetterRegex).evaluate(with: newPassword) {
            throw AuthValidationError.missingCapitalLetter
        }
        return newPassword
    }
    static func validate(password: String?, confirmPassword: String?) throws -> String {
        guard let password = password, !password.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyConfirmPassword
        }
        guard password == confirmPassword else {
            throw AuthValidationError.notMatchPasswords
        }
        return password
    }
    
    static func validate(newPassword: String?, confirmNewPassword: String?) throws -> String {
        guard let newPassword = newPassword, !newPassword.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyConfirmNewPassword
        }
        guard newPassword == confirmNewPassword else {
            throw AuthValidationError.notMatchPasswords
        }
        
        return newPassword
    }
    
    static func validate(verificationCode: String?) throws -> String {
        guard let verificationCode = verificationCode, !verificationCode.isEmpty else {
            throw AuthValidationError.emptyVerificationCode
        }
        guard verificationCode.count == 4 else {
            throw AuthValidationError.incorrectVerificationCode
        }
        return verificationCode
    }
    static func validate(complaintSubject: String?) throws -> String {
        guard let complaintSubject = complaintSubject, !complaintSubject.trimWhiteSpace().isEmpty else {
            throw AuthValidationError.emptyComplaint
        }
        guard complaintSubject.count > 5 else {
            throw AuthValidationError.shortComplaint
        }
        guard complaintSubject.count < 61 else {
            throw AuthValidationError.longComplaint
        }
        return complaintSubject
    }
}
