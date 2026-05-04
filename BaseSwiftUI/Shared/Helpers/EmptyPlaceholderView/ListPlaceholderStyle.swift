//
//  ListPlaceholderStyle.swift
//  CTF
//
//  Created by Ahmed Ramadan on 11/12/2025.
//


enum ListPlaceholderStyle {
    case emptyOrders
    case emptyNotifications
    case emptyChats
    case emptyData
    
    var title: String {
        switch self {
        case .emptyOrders:
            return "No Orders Found".helperLocalizable
        case .emptyNotifications:
            return "No Notifications Found".helperLocalizable
        case .emptyChats:
            return "No Chats Found".helperLocalizable
        case .emptyData:
            return "No Data Found".helperLocalizable
        }
    }
    
    var message: String {
        switch self {
        default:
            return ""
        }
    }
    
    var imageName: String {
        switch self {
        default:
            return "logo"
        }
    }
    
    var defaultActionTitle: String? {
        switch self {
        case .emptyOrders,
             .emptyNotifications,
             .emptyChats,
             .emptyData:
            return "Refresh".helperLocalizable
        }
    }
}

extension ListPlaceholderView {
    init(
        style: ListPlaceholderStyle,
        primaryAction: (() -> Void)? = nil
    ) {
        var actions: [Action] = []
        if let title = style.defaultActionTitle,
           let primaryAction {
            actions = [
                .init(title: title, action: primaryAction)
            ]
        }
        
        self.init(
            imageName: style.imageName,
            title: style.title,
            message: style.message,
            actions: actions
        )
    }
}
