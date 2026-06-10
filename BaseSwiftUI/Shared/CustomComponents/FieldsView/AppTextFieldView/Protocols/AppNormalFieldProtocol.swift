//
//  AppNormalFieldProtocol.swift
//  BaseSwiftUI
//
//  Created by Ahmed Ramadan on 10/06/2026.

import UIKit

//MARK: - protocol for Input Field cases (any view) -

protocol AppInputFieldProtocol {
    var isActive: Bool { get set }
    var isBordered: Bool { get }
    var isLeadingImage: Bool { get }
    var isMandatory: Bool { get }
    var isOptional: Bool { get }
    var fieldType: TextFieldType { get }
    var hasIcon: Bool { get set }
    func validate(_ text: String) -> String?
}

extension AppInputFieldProtocol{
    var isActive: Bool {return true}
    var isBordered: Bool {return false}
    var isLeadingImage: Bool {return true}
    var isMandatory: Bool {return false}
    var isOptional: Bool {return false}
    var hasIcon: Bool {return true}
    func validate(_ text: String) -> String? {return ""}
    
}


protocol AppTextFieldViewProtocol: AppInputFieldProtocol {}


protocol ValidationRule {
    func validate(_ text: String) -> String?
}

struct InputFieldConstants {
    static let fieldSapcing: CGFloat = 6
    static let fieldHeight: CGFloat = 44
    static let fieldCornerRaduis: CGFloat = 10
    static let containerBackground: UIColor = .secondarySystemBackground
}
