//
//  ItemListView.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/27.
//

import SwiftUI

struct ItemListView: View {
    let searchText: String
    
    var body: some View {
        LazyVStack(spacing: 12) {
            ForEach(0..<10) { index in
                HStack {
                    Image(systemName: "doc.text")
                        .foregroundColor(.blue)
                    VStack(alignment: .leading) {
                        Text("Item \(index + 1)")
                            .font(.headline)
                        Text("Sample description for item \(index + 1)")
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.vertical, 8)
                .background(Color(.systemGray6))
                .cornerRadius(8)
                .padding(.horizontal)
            }
            
            if !searchText.isEmpty {
                Text("Searching for: \(searchText)")
                    .foregroundColor(.secondary)
                    .font(.caption)
                    .padding()
            }
        }
        .padding(.top)
    }
}

#Preview {
    ItemListView(searchText: "")
}
