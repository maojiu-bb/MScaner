//
//  MainView.swift
//  MScaner
//
//  Created by 钟钰 on 2025/7/20.
//

import SwiftUI

struct MainView: View {
    @State private var isShowScanView: Bool = false
    
    
    var body: some View {
        NavigationStack {
            VStack {
                
            }
            .navigationTitle("MScaner")
            .navigationBarTitleDisplayMode(.automatic)
            .toolbar {
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
            .fullScreenCover(isPresented: $isShowScanView) {
                ScanView(isShowScanView: $isShowScanView)
            }
        }
    }
}

#Preview {
    MainView()
}
