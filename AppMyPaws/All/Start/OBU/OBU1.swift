//
//  OBU1.swift
//  AppMyPaws
//
//  Created by IGOR on 27/01/2025.
//

import SwiftUI

struct OBU1: View {
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("U1")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Fortune Tiger is your path to success. Play and Earn.")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .medium))
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        OBU2()
                            .navigationBarBackButtonHidden()
                        
                    }, label: {
                        
                        Text("Next")
                            .foregroundColor(.black)
                            .font(.system(size: 14, weight: .regular))
                            .frame(maxWidth: .infinity)
                            .frame(height: 40)
                            .background(RoundedRectangle(cornerRadius: 30).fill(.white))
                    })
                    .padding(.bottom)
                }
                .padding()
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .frame(height: 280)
                .background(Color.black)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OBU1()
}
