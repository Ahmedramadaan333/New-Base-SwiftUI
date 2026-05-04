//
//  AlertCenter.swift
//  CTF
//
//  Created by Ahmed Ramadan on 23/11/2025.
//


import SwiftUI

final class AlertCenter: ObservableObject {
    static let shared = AlertCenter()
    
    @Published var currentAlert: AppAlert?
    
    private var dismissWorkItem: DispatchWorkItem?
    
    private init() {}
    
    func show(
        style: AppAlertStyle,
        title: String? = "",
        message: String? = nil,
        autoDismissAfter seconds: TimeInterval = 2.5
    ) {
        let alert = AppAlert(title: title, message: message, style: style)
        
        dismissWorkItem?.cancel()
        
        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
            currentAlert = alert
        }
        
        let workItem = DispatchWorkItem { [weak self] in
            self?.dismiss()
        }
        dismissWorkItem = workItem
        
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: workItem)
    }
    
    func dismiss() {
        withAnimation(.spring(response: 0.3, dampingFraction: 0.9)) {
            currentAlert = nil
        }
    }
}
