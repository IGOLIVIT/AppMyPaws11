//
//  SettingsView.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI
import StoreKit

struct SettingsView: View {
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Text("Settings")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack(spacing: 15) {
                        
                        Button(action: {
                            
                            SKStoreReviewController.requestReview()
                            
                        }, label: {
                            
                            Text("Rate the app")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("bg2")))
                        })
                        
                        Button(action: {
                            
                            guard let url = URL(string: "https://www.termsfeed.com/live/8860d71b-8dc1-4f38-b27c-d6cb4d1a6bee") else { return }
                            
                            UIApplication.shared.open(url)
                            
                        }, label: {
                            
                            Text("Usage policy")
                                .foregroundColor(.white)
                                .font(.system(size: 16, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .frame(height: 40)
                                .background(RoundedRectangle(cornerRadius: 25).fill(Color("bg2")))
                        })
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
