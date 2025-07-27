//
//  CategoryDataManager.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/23.
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
        let fetchDescriptor = FetchDescriptor<CategoryModel>()
        
        do {
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
}
