//
//  MainCategoryView.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/20.
//

import SwiftUI

struct CategorySelector: View {
    var body: some View {
        HStack(spacing: 10) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    SelectorItem(
                        title: "All",
                        color: .purple,
                        isSelected: true,
                        icon: "tray"
                    )
                    SelectorItem(
                        title: "Image",
                        color: .pink,
                        isSelected: false,
                        icon: "photo"
                    )
                    SelectorItem(
                        title: "Docs",
                        color: .blue,
                        isSelected: false,
                        icon: "doc.text"
                    )
                    SelectorItem(
                        title: "Card",
                        color: .green,
                        isSelected: false,
                        icon: "list.dash.header.rectangle"
                    )
                }
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .padding(.horizontal)
    }
}

#Preview {
    CategorySelector()
}
