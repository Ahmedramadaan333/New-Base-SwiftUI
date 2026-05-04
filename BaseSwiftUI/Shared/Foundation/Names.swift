//
//  Names.swift
//  NewSwiftUIBase
//
//  Created by Ahmed Ramadan on 22/07/2025.
//


import Foundation

extension NSNotification.Name {
    
    /*
     Enum for Holding all strings keys as rawValues to avoid using Strings
     */
    private enum Names: String {
        case isLoginChanged
        case reloadOrderDetails
        case reloadMessages
        case reloadSettlements
    }
    
    
    /*
     All Notification cases
     */
    static let isLoginChanged = Notification.Name(rawValue: Names.isLoginChanged.rawValue)
    static let reloadOrderDetails = Notification.Name(rawValue: Names.reloadOrderDetails.rawValue)
    static let reloadSettlementDetails = Notification.Name(rawValue: Names.reloadSettlements.rawValue)
    static let reloadMessages = Notification.Name(rawValue: Names.reloadMessages.rawValue)
    
    
    
}
