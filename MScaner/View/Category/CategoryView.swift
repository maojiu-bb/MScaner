//
//  CategoryView.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/20.
//

import SwiftUI

struct CategoryView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var context
    let categories: [CategoryModel]
    
    var body: some View {
        NavigationStack{
            List {
                Section("Selected") {
                    ForEach(categories, id: \.id) { category in
                        if category.isSelected {
                            Label(
                                category.title,
                                systemImage: category.icon
                            )
                            .foregroundStyle(category.color)
                        }
                    }
                }
                
                Section("Categories") {
                    ForEach(categories, id: \.id) { category in
                        if !category.isSelected {
                            Label(
                                category.title,
                                systemImage: category.icon
                            )
                            .foregroundStyle(category.color)
                            .swipeActions(
                                edge: .trailing,
                                allowsFullSwipe: false
                            ) {
                                Button {
                                    deleteCategory()
                                } label: {
                                    Image(systemName: "trash.fill")
                                }
                                .tint(.red)
                                
                                Button {
                                    editCategory()
                                } label: {
                                    Image(systemName: "pencil.and.outline")
                                }
                                .tint(.yellow)
                            }
                            .swipeActions(
                                edge: .leading,
                                allowsFullSwipe: false
                            ) {
                                Button {
                                    selectedCategory(category)
                                } label: {
                                    Image(systemName: "pin.fill")
                                }
                                .tint(.blue)
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        CategoryAddView()
                    } label: {
                        Text("Add")
                    }
                }
            }
        }
    }
    
    private func deleteCategory() {
        
    }
    
    private func editCategory() {
        
    }
    
    private func selectedCategory(_ category: CategoryModel) {
        CategoryDataManager.shared.updateSelected(
            in: context,
            selectedCategory: category
        )
    }
}

#Preview {
    CategoryView(categories: [])
}
