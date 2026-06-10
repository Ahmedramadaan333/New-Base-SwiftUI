//
//  TextFieldType.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.
//

import Foundation


import UIKit

enum TextFieldType {
    //isSecureTextEntry
    //keyboardType
    case standard(title: String?, placeholder: String?, iconName: String?, isSecureTextEntry: Bool, keyboardType: UIKeyboardType)//validate: ValidationError
    case name
    case userName
    case fullName
    case fullNameProfile
    case firstName
    case secondName
    case lastName
    case email
    case currentEmail
    case newEmail
    case phone
    case phoneProfile
    case newPhone
    case currentPhone
    
    case password
    case confirmPassword
    case newPassword
    case confirmNewPassword
    case currentPassword
    
    case nationality
    case city
    case cities
    case country
    case countries
    case service
    case services
    case category
    case subCategory
    case categories
    case subCategories
    case address
    case location
    
    case bankAccountNumber
    case bankIpanNumber
    case bankName
    case bankAccountName
    case machineNumber
    
    case machineImage
    case driverLicenseImage
    case NationalIDImage
    
    case commercialNumber
    case nationalIDNumber
    case taxNumber
    
    
    case Date
    case otp
    
    case region
    case regionProfile
    
    // Extend with more types as needed.
    
    var fixedTitle: String? {
        switch self {
        case .standard(let title, _, _, _, _):
            return title
        case .name:
            return "name_field_title"
        case .userName:
            return "user_name_field_title"
        case .fullName:
            return "full_name_field_title"
        case .fullNameProfile:
            return "full_name_field_title"
        case .firstName:
            return "first_name_field_title"
        case .secondName:
            return "second_name_field_placeholder"
        case .lastName:
            return "last_name_field_placeholder"
        case .email:
            return "email_field_title"
        case .currentEmail:
            return "current_email_field_title"
        case .newEmail:
            return "new_email_field_title"
        case .phone:
            return "phone_field_title"
        case .phoneProfile:
            return "phone_field_title"
        case .currentPhone:
            return "current_phone_field_title"
        case .newPhone:
            return "new_phone_field_title"
        case .password:
            return "password_field_title"
        case .confirmPassword:
            return "confirm_password_field_title"
        case .newPassword:
            return "new_password_field_title"
        case .confirmNewPassword:
            return "confirm_new_password_field_title"
        case .currentPassword:
            return "current_password_field_title"
        case .nationality:
            return "nationality_field_title"
        case .city:
            return "city_field_title"
        case .cities:
            return "cities_field_title"
        case .country:
            return "country_field_title"
        case .countries:
            return "countries_field_title"
        case .service:
            return "service_type_field_title"
        case .services:
            return "services_types_field_title"
        case .category:
            return "main_category_field_title"
        case .subCategory:
            return "sub_category_field_title"
        case .categories:
            return "main_categories_field_title"
        case .subCategories:
            return "sub_categories_field_title"
        case .address:
            return "adress_field_title"
        case .location:
            return "location_field_title"
        case .bankAccountNumber:
            return "bank_account_number_field_title"
        case .bankIpanNumber:
            return "ipan_number_field_title"
        case .bankName:
            return "bank_name_field_title"
        case .bankAccountName:
            return "bank_account_name_field_title"
        case .machineNumber:
            return "machine_number_field_title"
        case .machineImage:
            return "machine_image_field_title"
        case .driverLicenseImage:
            return "driver_license_image_field_title"
        case .NationalIDImage:
            return "identity_image_field_title"
        case .Date:
            return ""
        case .otp:
            return "otp_field_title"
        case .commercialNumber:
            return "commercial_number_title"
        case .nationalIDNumber:
            return "national_id_number_title"
        case .taxNumber:
            return "tax_number_title"
        case .region:
            return "region_field_title"
        case .regionProfile:
            return "region_field_title"
        }
    }
    
    var fixedPlaceholder: String? {
        switch self {
        case .standard(_, let placeHolder, _, _, _):
            return placeHolder
        case .name:
            return "name_field_placeholder"
        case .userName:
            return "user_name_field_placeholder"
        case .fullName:
            return "full_name_field_placeholder"
        case .fullNameProfile:
            return "full_name_field_placeholder"
        case .firstName:
            return "first_name_field_placeholder"
        case .secondName:
            return "second_name_field_placeholder"
        case .lastName:
            return "last_name_field_placeholder"
        case .email:
            return "email_field_placeholder"
        case .currentEmail:
            return "current_email_field_placeholder"
        case .newEmail:
            return "new_email_field_placeholder"
        case .phone:
            return "phone_field_placeholder"
        case .phoneProfile:
            return "phone_field_placeholder"
        case .currentPhone:
            return "current_phone_field_placeholder"
        case .newPhone:
            return "new_phone_field_placeholder"
        case .password:
            return "password_field_placeholder"
        case .confirmPassword:
            return "confirm_password_field_placeholder"
        case .newPassword:
            return "new_password_field_placeholder"
        case .confirmNewPassword:
            return "confirm_new_password_field_placeholder"
        case .currentPassword:
            return "current_password_field_placeholder"
        case .nationality:
            return "nationality_field_placeholder"
        case .city:
            return "city_field_placeholder"
        case .cities:
            return "cities_field_placeholder"
        case .country:
            return "country_field_placeholder"
        case .countries:
            return "countries_field_placeholder"
        case .service:
            return "service_type_field_placeholder"
        case .services:
            return "services_types_field_placeholder"
        case .category:
            return "main_category_field_placeholder"
        case .subCategory:
            return "sub_category_field_placeholder"
        case .categories:
            return "main_categories_field_placeholder"
        case .subCategories:
            return "sub_categories_field_placeholder"
        case .address:
            return "adress_field_placeholder"
        case .location:
            return "location_field_placeholder"
        case .bankAccountNumber:
            return "bank_account_number_field_placeholder"
        case .bankIpanNumber:
            return "ipan_number_field_placeholder"
        case .bankName:
            return "bank_name_field_placeholder"
        case .bankAccountName:
            return "bank_account_number_field_placeholder"
        case .machineNumber:
            return "machine_number_field_placeholder"
        case .machineImage:
            return "machine_image_field_placeholder"
        case .driverLicenseImage:
            return "driver_license_image_field_placeholder"
        case .NationalIDImage:
            return "identity_image_field_placeholder"
        case .Date:
            return ""
        case .otp:
            return "otp_field_placeholder"
        case .commercialNumber:
            return "commercial_number_placeholder"
        case .nationalIDNumber:
            return "national_id_number_placeholder"
        case .taxNumber:
            return "tax_number_placeholder"
        case .region:
            return "region_field_placeholder"
        case .regionProfile:
            return "region_field_placeholder"
        }
    }
    
    var icon: UIImage?{
        switch self {
        case .standard(_, _, let icon, _, _):
            if let icon = icon {
                return UIImage(named: icon)
            } else {
                return nil
            }
           
        case .name, .userName, .firstName, .secondName, .fullName, .lastName:
            return UIImage(named: "nameIcon")
        case .fullNameProfile:
            return UIImage(named: "editNameIcon")
        case .email, .currentEmail, .newEmail:
            return UIImage(named: "emailIcon")
        case .phone, .newPhone, .currentPhone:
            return UIImage(named: "")
        case .phoneProfile:
            return UIImage(named: "phoneIcon")
        case .password, .confirmPassword, .newPassword, .confirmNewPassword, .currentPassword:
            return UIImage(named: "passwordIcon")
        case .nationality:
            return UIImage(named: "nameVector")
        case .city, .cities:
            return UIImage(named: "cityIcon")
        case .country, .countries:
            return UIImage(named: "cityIcon")
        case .service, .services:
            return UIImage(named: "serviceIcon")
        case .category:
            return nil
        case .subCategory:
            return nil
        case .categories, .subCategories:
            return UIImage(named: "categoryIcon")
        case .address:
            return UIImage(named: "locationIcon")
        case .location:
            return UIImage(named: "locate")
        case .bankAccountNumber:
            return UIImage(named: "ibanIcon")
        case .bankIpanNumber:
            return UIImage(named: "ibanIcon")
        case .bankName:
            return UIImage(named: "bankIcon")
        case .bankAccountName:
            return UIImage(named: "nameIcon")
        case .machineNumber:
            return UIImage(named: "nameVector")
        case .machineImage:
            return UIImage(named: "nameVector")
        case .driverLicenseImage:
            return UIImage(named: "nameVector")
        case .NationalIDImage:
            return UIImage(named: "nameVector")
        case .Date:
            return UIImage(named: "nameVector")
        case .otp:
            return UIImage(named: "passwordIcon")
        case .commercialNumber:
            return UIImage(named: "commercialNoIcon")
        case .nationalIDNumber:
            return UIImage(named: "commercialNoIcon")
        case .taxNumber:
            return UIImage(named: "commercialNoIcon")
        case .region:
            return nil
        case .regionProfile:
            return UIImage(named: "editRegionIcon")
        }
    }
}

extension TextFieldType {
    var isSecureTextEntry: Bool {
        switch self {
        case .standard(_, _, _, let isSecureTextEntry, _):
            return isSecureTextEntry
        case .name, .userName, .fullName, .firstName, .secondName, .lastName, .email, .currentEmail, .newEmail, .phone, .newPhone, .currentPhone:
            return false
        case .password, .confirmPassword, .newPassword, .confirmNewPassword, .currentPassword:
            return true
        case .nationality, .city, .cities, .country, .countries, .service, .services, .categories, .subCategories, .address, .location, .bankAccountNumber, .bankIpanNumber, .bankName, .bankAccountName, .machineNumber, .machineImage, .driverLicenseImage, .NationalIDImage, .Date, .otp:
            return false
        case .commercialNumber, .nationalIDNumber, .taxNumber:
            return false
        default:
            return false
        }
    }
    
    var keyboardType: UIKeyboardType {
        switch self {
        case .standard(_, _, _, _, let keyboardType):
            return keyboardType
        case .name, .userName, .fullName, .firstName, .secondName, .lastName:
            return .default
        case .phone, .newPhone, .currentPhone:
            return .asciiCapableNumberPad
        case .email, .currentEmail, .newEmail:
            return .emailAddress
        case .password, .confirmPassword, .newPassword, .confirmNewPassword, .currentPassword:
            return .asciiCapable
        case .bankAccountNumber:
            return .asciiCapableNumberPad
        case .machineNumber:
            return .asciiCapableNumberPad
        case .otp:
            return .asciiCapableNumberPad
        case .nationality, .city, .cities, .country, .countries, .service, .services, .categories, .subCategories, .address, .location, .bankName, .bankAccountName, .bankIpanNumber, .machineImage, .driverLicenseImage, .NationalIDImage, .Date:
            return .default
        case .commercialNumber, .nationalIDNumber, .taxNumber:
            return .asciiCapableNumberPad
        default:
            return .default
        }
    }
}
