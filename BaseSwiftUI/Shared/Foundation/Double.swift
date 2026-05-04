//
//  Double.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//

import Foundation

extension Double {
    var toPrice: String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".00", with: "") + " " + appCurrency
    }
    
    func toKiloMeter() -> String {
        return String(format: "%.01f", self) + " " + "Km"
    }
    func toString() -> String {
        return String(self)
    }
    func toPrecetage() -> String {
        return String(format: "%.01f", self) + " " + "%"
    }
    
    func toCoordinate() -> String {
        return String(format: "%.08f", self)
    }
    
}


extension Int {
    // isEven: -- self % 2 == 0
    var isEven: Bool { self.isMultiple(of: 2) }
    
    func toString() -> String {
        return String(self)
    }
    var toPrice: String {
        return String(format: "%.2f", self).replacingOccurrences(of: ".", with: "") + " " + appCurrency
    }
}

