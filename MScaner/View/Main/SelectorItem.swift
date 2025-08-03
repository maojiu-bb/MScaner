//
//  SelectorItem.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/20.
//

import SwiftUI

struct SelectorItem: View {
    @Environment(\.colorScheme) var colorScheme
    
    let title: String
    let color: Color
    let isSelected: Bool
    let icon: String
    
    var unSelectedColor: Color {
        if colorScheme == .light {
            return .black.opacity(0.8)
        } else {
            return .white.opacity(0.8)
        }
    }
    
    var body: some View {
        HStack(spacing: 5) {
            Image(systemName: icon)
                .foregroundStyle(isSelected ? .white : unSelectedColor)
            
            Text(title)
                .font(.subheadline.bold())
                .foregroundStyle(isSelected ? .white : unSelectedColor)
        }
            .padding(.horizontal, 15)
            .padding(.vertical, 8)
            .background(
                RoundedRectangle(
                    cornerRadius: 30,
                    style: .continuous
                )
                .fill(color.opacity(isSelected ? 1 : 0.1))
            )
            .overlay {
                RoundedRectangle(
                    cornerRadius: 30,
                    style: .continuous
                )
                .stroke(color)
            }
    }
}

#Preview {
    SelectorItem(
        title: "All", color: .purple, isSelected: false, icon: "plus"
    )
}
