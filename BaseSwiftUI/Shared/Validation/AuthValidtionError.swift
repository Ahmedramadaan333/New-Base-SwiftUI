//
//  AuthValidtionError.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 23/07/2025.
//

import Foundation

enum AuthValidationError: Error, Equatable {
    case emptyPhone
    case shortPhone
    case longPhone
    case emptyName
    case shortName
    case longName
    case emptyPassword
    case shortPassword
    case longPassword
    case invalidCharacters
    case emptyNewPassword
    case shortNewPassword
    case emptyOldPassword
    case shortOldPassword
    case emptyConfirmNewPassword
    case emptyConfirmPassword
    case notMatchPasswords
    case missingLetter, missingNumber, missingSymbol, missingCapitalLetter
    case terms
    case emptyArabicName
    case shortArabicName
    case longArabicName
    case emptyEnglishName
    case shortEnglishName
    case longEnglishName
    //MARK: - Verification Code -
    case emptyVerificationCode
    case incorrectVerificationCode
    case emptyComplaint
    case shortComplaint
    case longComplaint
    
}
extension AuthValidationError:LocalizedError {
    var errorDescription: String? {
        switch self{
        case .emptyPhone:
            return "Please enter your phone number.".validationLocalized
        case .shortPhone:
            return "Phone number is too short, Please enter correct phone number.".validationLocalized
        case .longPhone:
            return "Phone number is too long, please enter correct number.".validationLocalized
        case .emptyName:
            return "Please enter name.".validationLocalized
        case .shortName:
            return "Name is too short.".validationLocalized
        case .longName:
            return "Name is too long.".validationLocalized
        case .emptyPassword:
            return "EMPTY_PASSWORD".validationLocalized
        case .shortPassword:
            return "SHORT_PASSWORD".validationLocalized
        case .longPassword:
            return "LONG_PASSWORD".validationLocalized
        case .invalidCharacters:
            return "INVALID_CHARACTERS".validationLocalized
        case .missingLetter:
            return "Password must contain at least one letter.".validationLocalized
        case .missingNumber:
            return "Password must contain at least one number.".validationLocalized
        case .missingSymbol:
            return "Password must contain at least one special character.".validationLocalized
        case .missingCapitalLetter:
            return "Password must contain at least one uppercase letter.".validationLocalized
        case .emptyNewPassword:
            return "Please enter new password field.".validationLocalized
        case .shortNewPassword:
            return "New password is too short, it should be 6 characters at least.".validationLocalized
        case .emptyOldPassword:
            return "Please enter old password field.".validationLocalized
        case .shortOldPassword:
            return "Old password is too short, it should be 6 characters at least.".validationLocalized
        case .emptyConfirmNewPassword:
            return "Please enter confirm new password field.".validationLocalized
        case .emptyConfirmPassword:
            return "Please enter confirm password field.".validationLocalized
        case .notMatchPasswords:
            return "Passwords not match.".validationLocalized
        case .terms:
            return "Please read and agree our terms and conditions first".validationLocalized
        case .emptyArabicName:
            return "Please enter Arabic name.".validationLocalized
        case .shortArabicName:
            return "Name is too Arabic short.".validationLocalized
        case .longArabicName:
            return "Name is too Arabic long.".validationLocalized
        case .emptyEnglishName:
            return "Please enter English name.".validationLocalized
        case .shortEnglishName:
            return "Name is too English short.".validationLocalized
        case .longEnglishName:
            return "Name is too English long.".validationLocalized
            //MARK: - Verification Code -
        case .emptyVerificationCode:
            return "Please enter verification code field.".validationLocalized
        case .incorrectVerificationCode:
            return "Verification Code should be 4 digits.".validationLocalized
            
        case .emptyComplaint:
            return "Please enter complaint field.".validationLocalized
        case .shortComplaint:
            return "Complaint is too short. must be more than 4 characters.".validationLocalized
        case .longComplaint:
            return "Complaint is too long. must be less than 256 characters.".validationLocalized
        
        }
    }
}
