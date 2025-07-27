//
//  MainCategoryView.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/20.
//

import SwiftUI
import SwiftData

struct CategorySelector: View {
    @Environment(\.modelContext) private var modelContext
    
    let categories: [CategoryModel]
    
    var body: some View {
        HStack(spacing: 10) {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(categories, id: \.id) { category in
                        SelectorItem(
                            title: category.title,
                            color: category.color,
                            isSelected: category.isSelected,
                            icon: category.icon
                        )
                        .onTapGesture {
                            CategoryDataManager.shared.updateSelected(in: modelContext, selectedCategory: category)
                        }
                    }
                }
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .padding(.horizontal)
        .onAppear {
            CategoryDataManager.shared.setupDefaultCategoriesOnFirstLaunch(in: modelContext)
        }
    }
}

//#Preview {
//    CategorySelector()
//}
