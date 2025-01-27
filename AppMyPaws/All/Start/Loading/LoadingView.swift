//
//  LoadingView.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("nlogo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 170)
                    .cornerRadius(20)
            }
            
            VStack {
                
                Spacer()
                
                ProgressView()
                    .padding(.bottom, 100)
            }
        }
    }
}

#Preview {
    LoadingView()
}
