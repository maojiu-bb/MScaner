//
//  CategoryModel.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/23.
//

import Foundation
import SwiftData
import SwiftUI

@Model
class CategoryModel {
    var id: Int
    var title: String
    var icon: String
    var colorHex: String
    var isSelected: Bool
    
    @Transient var color: Color {
        get {
            Color(hex: colorHex) ?? .blue
        }
        set {
            colorHex = Self.colorToHex(newValue)
        }
    }
    
    init(id: Int, title: String, icon: String, color: Color, isSelected: Bool) {
        self.id = id
        self.title = title
        self.icon = icon
        self.colorHex = Self.colorToHex(color)
        self.isSelected = isSelected
    }
    
    init(id: Int, title: String, icon: String, colorHex: String, isSelected: Bool) {
        self.id = id
        self.title = title
        self.icon = icon
        self.colorHex = colorHex
        self.isSelected = isSelected
    }
    
    // Color转16进制字符串
    static func colorToHex(_ color: Color) -> String {
        return color.toHex()
    }
    
    // 更新颜色
    func updateColor(_ newColor: Color) {
        self.colorHex = Self.colorToHex(newColor)
    }
}
