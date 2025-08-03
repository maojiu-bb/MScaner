//
//  CategoryAddView.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/27.
//

import SwiftUI

struct CategoryAddView: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    
    @State private var categoryTitle: String = "Category Title"
    @State private var selectedColor: Color = .blue
    @State private var selectedIcon: String = "house"
    
    @FocusState private var focusedField: Field?
    
    var category: CategoryModel?
    
    var navigationTitle: String {
        return category == nil ? "Add Category" : "Edit Category"
    }
    
    enum Field {
        case title, icon
    }
    
    private let icons: [String] = [
        "house",
        "tray",
        "list.dash.header.rectangle",
        "doc.text",
        "photo",
        "car",
        "airplane",
        "heart",
        "star",
        "music.note",
        "gamecontroller",
        "building",
        "building.2",
        "house.fill",
        "building.columns",
        "location",
        "map",
        "globe",
        "flag",
        "signpost.right",
        "mountain.2",
        "bicycle",
        "bus",
        "tram",
        "ferry",
        "sailboat",
        "motorcycle",
        "scooter",
        "train.side.front.car",
        "fuelpump",
        "sun.max",
        "cloud",
        "cloud.rain",
        "snow",
        "bolt",
        "leaf",
        "tree",
        "flame",
        "dog",
        "cat",
        "bird",
        "fish",
        "hare",
        "tortoise",
        "ladybug",
        "ant",
        "fork.knife",
        "cup.and.saucer",
        "wineglass",
        "birthday.cake",
        "carrot",
        "scribble.variable",
        "leaf.arrow.circlepath",
        "takeoutbag.and.cup.and.straw",
        "figure.run",
        "figure.walk",
        "dumbbell",
        "tennis.racket",
        "football",
        "basketball",
        "baseball",
        "iphone",
        "ipad",
        "laptopcomputer",
        "desktopcomputer",
        "tv",
        "headphones",
        "camera",
        "video",
        "printer",
        "scanner",
        "briefcase",
        "hammer",
        "wrench",
        "screwdriver",
        "paintbrush",
        "scissors",
        "paperclip",
        "folder",
        "book",
        "magazine",
        "film",
        "tv.music.note",
        "theatermasks",
        "paintpalette",
        "guitars",
        "microphone",
        "checkmark",
        "xmark",
        "plus",
        "minus",
        "multiply",
        "divide",
        "percent",
        "at",
        "number",
        "questionmark",
        "cart",
        "bag",
        "creditcard",
        "banknote",
        "gift",
        "tag",
        "calendar",
        "person.crop.square"
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    VStack(spacing: 15) {
                        Image(systemName: selectedIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundStyle(selectedColor)
                            .padding(30)
                            .background(
                                Circle()
                                    .fill(selectedColor.opacity(0.1))
                            )
                            .overlay(
                                Circle()
                                    .stroke(
                                        selectedColor.opacity(0.3),
                                        lineWidth: 2
                                    )
                            )
                        
                        Text(categoryTitle)
                            .font(.title2.bold())
                            .foregroundStyle(.primary)
                    }
                    
                    VStack {
                        HStack {
                            Text("Title")
                                .foregroundColor(.secondary)
                            Spacer()
                            TextField(
                                "Enter category title",
                                text: $categoryTitle
                            )
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.default)
                            .focused($focusedField, equals: .icon)
                            .submitLabel(.done)
                            .onSubmit {
                                focusedField = nil
                            }
                        }
                        
                        Divider()
                            .padding(.vertical, 5)
                        
                        HStack {
                            Text("Color")
                                .foregroundStyle(.secondary)
                            Spacer()
                                .foregroundColor(.secondary)
                            ColorPicker("", selection: $selectedColor)
                                .labelsHidden()
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: 16,
                            style: .continuous
                        )
                        .fill(.background)
                    )
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading) {
                        Text("Icon")
                            .foregroundColor(.secondary)
                            .padding(.bottom, 8)
                        
                        let columns = Array(
                            repeating: GridItem(.flexible()),
                            count: 5
                        )
                        
                        LazyVGrid(columns: columns, spacing: 16) {
                            ForEach(icons, id: \.self) { icon in
                                Button {
                                    selectedIcon = icon
                                } label: {
                                    Image(systemName: icon)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 24, height: 24)
                                        .foregroundStyle(selectedIcon == icon ? selectedColor : .secondary)
                                        .padding(12)
                                        .background(
                                            RoundedRectangle(cornerRadius: 12)
                                                .fill(selectedIcon == icon ? selectedColor.opacity(0.1) : Color(.systemGray6))
                                        )
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 12)
                                                .stroke(
                                                    selectedIcon == icon ? selectedColor : .clear,
                                                    lineWidth: 2
                                                )
                                        )
                                }
                                .buttonStyle(.plain)
                            }
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(
                            cornerRadius: 16,
                            style: .continuous
                        )
                        .fill(.background)
                    )
                    .padding(.top, 20)
                }
                .padding(.horizontal, 20)
            }
            .navigationTitle(navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemGroupedBackground))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        onDoneTap()
                    } label: {
                        Text("Done")
                    }
                    
                }
            }
            .onAppear {
                setupInitialValues()
            }
        }
    }
    
    private func setupInitialValues() {
        if let category = category {
            categoryTitle = category.title
            selectedIcon = category.icon
            selectedColor = category.color
        } else {
            categoryTitle = "Category Title"
            selectedColor = .blue
            selectedIcon = "house"
        }
    }
    
    private func onDoneTap() {
        Task {
            if let category = self.category {
                let updateCategory: CategoryModel = CategoryModel(
                    id: category.id,
                    title: categoryTitle,
                    icon: selectedIcon,
                    color: selectedColor,
                    isSelected: category.isSelected
                )
                
                CategoryDataManager.shared.updateCategory(
                    in: context,
                    updatedCategory: updateCategory
                ) {
                    dismiss()
                }
            } else {
                CategoryDataManager.shared.addCategory(
                    in: context,
                    title: categoryTitle,
                    icon: selectedIcon,
                    color: selectedColor
                ) {
                    dismiss()
                }
            }
        }
    }
}

#Preview {
    CategoryAddView()
}
