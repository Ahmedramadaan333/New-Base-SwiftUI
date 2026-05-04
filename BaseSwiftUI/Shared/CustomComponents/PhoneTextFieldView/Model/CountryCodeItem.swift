//
//  CountryCodeItem.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 30/07/2025.
//


// MARK: - Protocol for Country

protocol CountryCodeModel: Identifiable, Equatable {
    var pickerId: Int { get }
    var countryCode: String? { get }
    var countryName: String { get }
    var image: String? { get }
}

struct CountriesDataModel: Equatable, CountryCodeModel {
    var id: Int?
    var name: String?
    var key: String?
    var flag: String?

    var pickerId: Int { id ?? 0 }
    var countryCode: String? { key }
    var countryName: String { name ?? "" }
    var image: String? { flag }
}

extension CountriesDataModel: Decodable {
    enum CodingKeys: String, CodingKey {
        case id, name, key, flag
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(Int.self, forKey: .id)
        name = try? container.decode(String.self, forKey: .name)
        key = try? container.decode(String.self, forKey: .key)
        flag = try? container.decode(String.self, forKey: .flag)
    }
}
