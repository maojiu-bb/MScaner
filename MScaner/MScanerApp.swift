//
//  MScanerApp.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/20.
//

import SwiftUI
import SwiftData

@main
struct MScanerApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [CategoryModel.self])
        }
    }
}
