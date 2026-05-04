//
//  HalfStarRatingView.swift
//  CTF
//
//  Created by Ahmed Ramadan on 13/02/2026.
//

// MARK: - Half Star Rating View (Tap + Drag)
import SwiftUI

struct HalfStarRatingView: View {
    @Binding var rating: Double
    
    let maxStars: Int = 5
    let starSize: CGFloat = 36
    let spacing: CGFloat = 8
    
    private var isRTL: Bool {
        AppLanguageManager.isRTL()
    }
    
    private var totalWidth: CGFloat {
        CGFloat(maxStars) * starSize + CGFloat(maxStars - 1) * spacing
    }
    
    var body: some View {
        HStack(spacing: spacing) {
            ForEach(1...maxStars, id: \.self) { star in
                starImage(for: star)
                    .resizable()
                    .scaledToFit()
                    .frame(width: starSize, height: starSize)
                    .foregroundColor(starColor(for: star))
            }
        }
        .environment(\.layoutDirection, isRTL ? .rightToLeft : .leftToRight)
        .contentShape(Rectangle())
        .gesture(
            DragGesture(minimumDistance: 0)
                .onChanged { value in
                    updateRating(from: value.location.x)
                }
        )
    }
    
    private func updateRating(from locationX: CGFloat) {
        let x = min(max(locationX, 0), totalWidth)
        
        // In RTL, flip the x so dragging right→left increases rating
        let effectiveX = isRTL ? (totalWidth - x) : x
        
        let unitWidth = starSize + spacing
        let starIndex = Int(effectiveX / unitWidth)
        let clampedIndex = min(starIndex, maxStars - 1)
        let positionInStar = effectiveX - CGFloat(clampedIndex) * unitWidth
        
        let newRating: Double
        if positionInStar <= starSize / 2 {
            newRating = Double(clampedIndex) + 0.5
        } else {
            newRating = Double(clampedIndex) + 1.0
        }
        
        withAnimation(.easeInOut(duration: 0.1)) {
            rating = min(max(newRating, 0.5), Double(maxStars))
        }
    }
    
    private func starImage(for star: Int) -> Image {
        let value = Double(star)
        if rating >= value {
            return Image(systemName: "star.fill")
        } else if rating >= value - 0.5 {
            return Image(systemName: isRTL ? "star.leadinghalf.filled" : "star.leadinghalf.filled")
        } else {
            return Image(systemName: "star")
        }
    }
    
    private func starColor(for star: Int) -> Color {
        let value = Double(star)
        if rating >= value - 0.5 {
            return .yellow
        }
        return .gray.opacity(0.4)
    }
}
