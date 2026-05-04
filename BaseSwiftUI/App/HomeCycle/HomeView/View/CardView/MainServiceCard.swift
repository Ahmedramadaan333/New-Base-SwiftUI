//
//  MainServiceCard.swift
//  CTF
//
//  Created by Ahmed Ramadan on 08/12/2025.
//

import SwiftUI

struct MainServiceCard: View {
    let title: String
    let subtitle: String
    let buttonTitle: String
    let imageURL: String
    var action: (() -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(AppFont.medium(size: 16))
                
                Text(subtitle)
                    .font(AppFont.regular(size: 14))
                    .foregroundStyle(Color(.secondaryTextFont))
                HStack{
                    Button {
                        action?()
                    } label: {
                        Text(buttonTitle)
                            .font(AppFont.medium(size: 12))
                    }
                    Image(systemName: "chevron.forward")
                        .foregroundStyle(Color(.primaryMain))
                        .frame(width: 15, height: 15)
                }
            }
            Spacer()
            RemoteImageView(url: imageURL)
                .scaledToFit()
                .frame(width: 100, height: 100)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 1)
            
        )
    }
}

struct NotchedRoundedRect: Shape {
    var cornerRadius: CGFloat = 16
    var notchRadius: CGFloat = 26
    
    func path(in rect: CGRect) -> Path {
        let r = min(cornerRadius, min(rect.width, rect.height) / 2)
        let n = min(notchRadius, rect.width * 0.35)
        let cx = rect.midX
        let right = cx + n
        
        var p = Path()
        
        p.move(to: CGPoint(x: rect.minX + r, y: rect.minY))
        
        // Top
        p.addLine(to: CGPoint(x: rect.maxX - r, y: rect.minY))
        p.addArc(center: CGPoint(x: rect.maxX - r, y: rect.minY + r),
                 radius: r, startAngle: .degrees(-90), endAngle: .degrees(0), clockwise: false)
        
        // Right
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY - r))
        p.addArc(center: CGPoint(x: rect.maxX - r, y: rect.maxY - r),
                 radius: r, startAngle: .degrees(0), endAngle: .degrees(90), clockwise: false)
        
        // Bottom to notch
        p.addLine(to: CGPoint(x: right, y: rect.maxY))
        
        // Concave notch (indent upward)
        p.addArc(center: CGPoint(x: cx, y: rect.maxY),
                 radius: n, startAngle: .degrees(0), endAngle: .degrees(180), clockwise: true)
        
        // Bottom left
        p.addLine(to: CGPoint(x: rect.minX + r, y: rect.maxY))
        p.addArc(center: CGPoint(x: rect.minX + r, y: rect.maxY - r),
                 radius: r, startAngle: .degrees(90), endAngle: .degrees(180), clockwise: false)
        
        // Left
        p.addLine(to: CGPoint(x: rect.minX, y: rect.minY + r))
        p.addArc(center: CGPoint(x: rect.minX + r, y: rect.minY + r),
                 radius: r, startAngle: .degrees(180), endAngle: .degrees(270), clockwise: false)
        
        p.closeSubpath()
        return p
    }
}

struct SmallServiceCard: View {
    let title: String
    let imageName: String
    var action: (() -> Void)? = nil
    
    private let notchRadius: CGFloat = 26
    private let circleSize: CGFloat = 36
    private let arrowSize: CGFloat = 18
    
    var body: some View {
        Button { action?() } label: {
            ZStack {
                NotchedRoundedRect(cornerRadius: 16, notchRadius: notchRadius)
                    .fill(Color.white)
                    .shadow(color: .black.opacity(0.05), radius: 8, x: 0, y: 3)
                
                VStack(spacing: 8) {
                    RemoteImageView(url: imageName)
                        .scaledToFit()
                        .frame(height: 60)
                    
                    Text(title)
                        .font(AppFont.medium(size: 16))
                        .foregroundColor(.primaryText)
                }
                .frame(maxWidth: .infinity)
                .padding(12)
                .padding(.bottom, notchRadius + 10)
            }
            .overlay(alignment: .bottom) {
                Circle()
                    .fill(Color.white)
                    .frame(width: circleSize, height: circleSize)
                    .shadow(color: .black.opacity(0.08), radius: 6, x: 0, y: 2)
                    .overlay {
                        Image(systemName: "chevron.forward")
                            .resizable()
                            .foregroundStyle(AppStyle.mainOrderGradient)
                            .scaledToFit()
                            .frame(width: arrowSize, height: arrowSize)
                    }
                .offset(y: (circleSize - notchRadius) / 2 + 8)
            }
        }
        .buttonStyle(.plain)
    }
}

