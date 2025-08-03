//
//  CategoryDataManager.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/23.
//

import Foundation
import SwiftUI
import SwiftData

class CategoryDataManager {
    static let shared = CategoryDataManager()
    
    private let hasInsertedDefaultCategoryData: String = "hasInsertedDefaultCategoryData"
    
    private let defaultCategories: [(id: Int, title: String, icon: String, color: Color, isSelected: Bool)] = [
        (1, "All", "tray", .blue, true),
        (2, "Docs", "doc.text", .purple, false),
        (3, "Image", "photo", .pink, false),
        (4, "Card", "list.dash.header.rectangle", .brown, false)
    ]
    
    private func setupDefaultCategories(in context: ModelContext) {
        do {
            let fetchDescriptor = FetchDescriptor<CategoryModel>()
            let existCategories = try context.fetch(fetchDescriptor)
            
            if existCategories.isEmpty {
                
                for categoryData in defaultCategories {
                    let categoryData = CategoryModel(
                        id: categoryData.id,
                        title: categoryData.title,
                        icon: categoryData.icon,
                        color: categoryData.color,
                        isSelected: categoryData.isSelected
                    )
                    
                    context.insert(categoryData)
                }
                
                try context.save()
            }
        } catch {
            print("setup default categories failed.")
        }
    }
    
    func setupDefaultCategoriesOnFirstLaunch(in context: ModelContext) {
        let hasInsertedData = UserDefaults.standard.bool(forKey: hasInsertedDefaultCategoryData)
        
        if !hasInsertedData {
            setupDefaultCategories(in: context)
            
            UserDefaults.standard.set(true, forKey: hasInsertedDefaultCategoryData)
        }
    }
    
    func resetFirstLaunchFlag() {
        UserDefaults.standard.removeObject(forKey: hasInsertedDefaultCategoryData)
    }
    
    func updateSelected(in context: ModelContext, selectedCategory: CategoryModel) {
        do {
            let fetchDescriptor = FetchDescriptor<CategoryModel>()
            let allCategories = try context.fetch(fetchDescriptor)
            
            for category in allCategories {
                category.isSelected = false
            }
            
            selectedCategory.isSelected = true
            
            try context.save()
        } catch {
            print("update selected faild")
        }
    }
    
    func addCategory(in context: ModelContext, title: String, icon: String, color: Color, onSuccess: @escaping () -> Void) {
        do {
            var fetchDescriptor = FetchDescriptor<CategoryModel>(
                sortBy: [SortDescriptor(\.id, order: .reverse)]
            )
                
            fetchDescriptor.fetchLimit = 1
            
            guard let maxId = try context.fetch(fetchDescriptor).first?.id else {
                return
            }
            let nextId = maxId + 1
            
            let categoryData = CategoryModel(
                id: nextId,
                title: title,
                icon: icon,
                color: color,
                isSelected: false
            )
            
            context.insert(categoryData)
            
            try context.save()
            onSuccess()
        } catch {
            print("add category faild")
        }
    }
    
    func deleteCategory(in context: ModelContext, id: Int) {
        do {
            let fetchDescriptor = FetchDescriptor<CategoryModel>(
                predicate: #Predicate { $0.id == id }
            )
            guard let category = try context.fetch(fetchDescriptor).first else {
                return
            }
            
            context.delete(category)
            
            try context.save()
        } catch {
            print("delete category faild")
        }
    }
    
    func updateCategory(in context: ModelContext, updatedCategory: CategoryModel, onSuccess: @escaping () -> Void) {
        do {
            let targetId = updatedCategory.id
            
            let fetchDescriptor = FetchDescriptor<CategoryModel>(
                predicate: #Predicate<CategoryModel> { $0.id == targetId }
            )
            guard let oldCategory = try context.fetch(fetchDescriptor).first else {
                return
            }
            
            oldCategory.title = updatedCategory.title
            oldCategory.icon = updatedCategory.icon
            oldCategory.color = updatedCategory.color
            
            try context.save()
            
            onSuccess()
        } catch {
            print("update category faild")
        }
    }
}
