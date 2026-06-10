//
//  TextFieldTypeCases.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.
//

import Foundation

struct UserNameFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .userName
   
}

struct NameFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .name
    func validate(_ text: String) -> String? {
        do {
            _ = try AuthValidationService.validate(name: text)
            return nil
        }catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return "Invalid value"
        }
    }
}

struct FullNameFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .fullName
}

struct complaintReasonFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = false
    var fieldType: TextFieldType = .standard(
        title: "complaint_reason_title",
        placeholder: "complaint_reason_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

struct OrderComplaintReasonFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = false
    var fieldType: TextFieldType = .standard (
        title: "order_complaint_reason_title",
        placeholder: "order_complaint_reason_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

struct EmailFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var isMandatory: Bool = false
    var fieldType: TextFieldType = .email
}

struct AboutYouFieldcase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "about_you_field_title",
        placeholder: "about_you_field_placeholder",
        iconName: "aboutYouIcon",
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

struct PasswordFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .password
    func validate(_ text: String) -> String? {
        do {
            _ = try AuthValidationService.validate(password: text)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return "Invalid value"
        }
    }
}

struct CurrentPasswordFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .currentPassword
}

struct ConfirmPasswordFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .confirmPassword
    var password: String = ""
    func validate(_ text: String) -> String? {
        do {
            _ = try AuthValidationService.validate(password: password, confirmPassword: text)
            return nil
        } catch let error as AuthValidationError {
            return error.localizedDescription
        } catch {
            return "Invalid value"
        }
    }
}

struct NewPasswordFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .newPassword
}

struct ConfirmNewPasswordFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .confirmNewPassword
}

struct OtpFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .otp
}

struct ChargeBalanceFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "charge_balance_title", placeholder: "charge_balance_placeholder", iconName: "nameIcon", isSecureTextEntry: false, keyboardType: .asciiCapableNumberPad)
}

//MARK: - Provider Cases -
struct StoreArabicNameFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "store_name_with_arabic_lang_title", placeholder: "store_name_with_arabic_lang_placeholder", iconName: "storeNameIcon", isSecureTextEntry: false, keyboardType: .default)
}

struct StoreEnglishNameFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "store_name_with_english_lang_title", placeholder: "store_name_with_english_lang_placeholder", iconName: "storeNameIcon", isSecureTextEntry: false, keyboardType: .default)
}

struct BankAccountNumberFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .bankAccountNumber
}

struct IpanNumberFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .bankIpanNumber
}

struct CommercialNumberFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .commercialNumber
}

struct NationalIDNumberFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .nationalIDNumber
}

struct TaxNumberFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .taxNumber
}

//MARK: - Provider Add Product -
struct ProductArabicNameFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "product_arabic_name_field_title", placeholder: "product_arabic_name_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .default)
}

struct ProductEnglishNameFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "product_english_name_field_title", placeholder: "product_english_name_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .default)
}

struct NumberOfUsageProductFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "number_of_usage_product_field_title", placeholder: "number_of_usage_product_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .asciiCapableNumberPad)
}

struct QuantityInStockFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "quantity_in_stock_field_title", placeholder: "quantity_in_stock_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .asciiCapableNumberPad)
}

//MARK: -  Create Announcement -
struct AnnouncementTitleFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "announcement_title_field_title", placeholder: "announcement_title_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .default)
}

struct PreviewAnnouncementNumberOfDaysFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .standard(title: "PreviewAnnouncementNumberOfDays_field_title", placeholder: "PreviewAnnouncementNumberOfDays_field_Placeholder", iconName: nil, isSecureTextEntry: false, keyboardType: .asciiCapableNumberPad)
}

//MARK: - Contactus Reason -
struct ContactReasonFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = false
    var fieldType: TextFieldType = .standard(
        title: "contact_reason_field_title",
        placeholder: "contact_reason_field_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

// profile
struct PhoneProfileFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = true
    //var selectedCountryCode: BottomSheetData?
    var fieldType: TextFieldType = .phoneProfile
}


struct FullNameProfileFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var hasIcon: Bool = true
    var fieldType: TextFieldType = .fullNameProfile
}

struct RegionProfileFieldCase: AppTextFieldViewProtocol{
    var isActive: Bool = true
    var isBordered: Bool = true
    var hasIcon: Bool = true
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .regionProfile
}

// Delete Account

struct DeleteAccountReasonFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var isBordered: Bool = true
    var hasIcon: Bool = true
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "DeleteAccountReason_title",
        placeholder: "DeleteAccountReason_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

//MARK: - Pick Location Types -

struct PickLocationFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = false
    var isBordered: Bool = true
    var hasIcon: Bool = false
    //var isLeadingImage: Bool = false
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard (
        title: "PickLocationField_title",
        placeholder: "PickLocationField_placeholder",
        iconName: nil,//"locationIcon",
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

//MARK: - Cancel Reason  -
struct CancelReasonFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = false
    var isBordered: Bool = true
    var hasIcon: Bool = true
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "CancelReasonField_title",
        placeholder: "CancelReasonField_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

//MARK: - reject Reason -
struct RejectReasonFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = false
    var isBordered: Bool = true
    var hasIcon: Bool = false
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "RejectReasonField_title",
        placeholder: "RejectReasonField_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

//MARK: - Medical Fields -
struct HeightFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var isBordered: Bool = true
    var hasIcon: Bool = false
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "Height_Field_title",
        placeholder: "Height_Field_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

struct WeightFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var isBordered: Bool = true
    var hasIcon: Bool = false
    var isMandatory: Bool = true
    var fieldType: TextFieldType = .standard(
        title: "Weight_Field_title",
        placeholder: "Weight_Field_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}

struct WrittenAddressFieldCase: AppTextFieldViewProtocol {
    var isActive: Bool = true
    var hasIcon: Bool = false
    var fieldType: TextFieldType = .standard(
        title: "writtenـaddress_title",
        placeholder: "writtenـaddress_placeholder",
        iconName: nil,
        isSecureTextEntry: false,
        keyboardType: .default
    )
}
