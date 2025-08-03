//
//  MainCategoryView.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/20.
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
                            Task {
                                CategoryDataManager.shared.updateSelected(
                                    in: modelContext,
                                    selectedCategory: category
                                )
                            }
                        }
                    }
                }
            }
            .scrollTargetBehavior(.viewAligned)
        }
        .padding(.horizontal)
        .onAppear {
            Task {
                CategoryDataManager.shared.setupDefaultCategoriesOnFirstLaunch(in: modelContext)
            }
        }
    }
}

//#Preview {
//    CategorySelector()
//}
