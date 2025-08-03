//
//  ScanView.swift
//  MScaner
//
//  Created by MaoJiu on 2025/7/20.
//

import SwiftUI

struct ScanView: View {
    @Binding var isShowScanView: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button {
                        isShowScanView = false
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 12, height: 12)
                            .padding(13)
                            .background(
                                Circle().fill(.regularMaterial)
                            )
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(.horizontal, 30)
        }
        .background(.black)
    }
}

#Preview {
    ScanView(isShowScanView: .constant(true))
}
