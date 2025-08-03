//
//  MainView.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/20.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isShowScanView: Bool = false
    @State private var isShowCategorySheet: Bool = false
    @State private var searchText: String = ""
    
    @Query(sort: \CategoryModel.id, order: .forward) private var categories: [CategoryModel]
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                CategorySelector(categories: categories)
                ItemListView(searchText: searchText)
            }
            .navigationTitle("MScaner")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        isShowCategorySheet = true
                    } label: {
                        Image(systemName: "folder.badge.plus")
                    }
                }
                ToolbarItem {
                    Button {
                        isShowScanView = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                ToolbarItem {
                    NavigationLink {
                        SettingView()
                    } label: {
                        Image(systemName: "gear")
                    }
                    
                }
            }
            .toolbarTitleDisplayMode(.automatic)
            .searchable(text: $searchText, prompt: "Search")
            .sheet(isPresented: $isShowCategorySheet) {
                CategoryView(categories: categories)
            }
            .fullScreenCover(isPresented: $isShowScanView) {
                ScanView(isShowScanView: $isShowScanView)
            }
        }
    }
}

#Preview {
    MainView()
}
