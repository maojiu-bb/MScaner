//
//  MainView.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/20.
//

import SwiftUI

struct MainView: View {
    @State private var isShowScanView: Bool = false
    @State private var isShowCategorySheet: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                CategorySelector()
                Spacer()
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
            .sheet(isPresented: $isShowCategorySheet) {
                CategoryView()
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
