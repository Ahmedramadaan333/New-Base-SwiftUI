//
//  GeneralPickerModel.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 29/07/2025.
//


protocol GeneralPickerModel: Identifiable, Equatable {
    var pickerId: Int { get }
    var pickerTitle: String { get }
    var pickerImage: String? { get }
    var pickerSlug: String? { get }
}

extension GeneralPickerModel {
    var id: Int { pickerId }
    var stableListID: String { pickerSlug ?? "\(pickerId)" }
}


@propertyWrapper
struct StringOrInt: Codable, Equatable {
    var wrappedValue: String?

    init(wrappedValue: String?) { self.wrappedValue = wrappedValue }

    init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        if let s = try? c.decode(String.self) {
            wrappedValue = s
        } else if let i = try? c.decode(Int.self) {
            wrappedValue = String(i)
        } else {
            wrappedValue = nil
        }
    }

    func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        try c.encode(wrappedValue)
    }

    static func == (lhs: StringOrInt, rhs: StringOrInt) -> Bool {
        lhs.wrappedValue == rhs.wrappedValue
    }
}
