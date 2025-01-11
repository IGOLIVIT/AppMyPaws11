//
//  OB1.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct OB1: View {
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("ob1")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Add your pets")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                    
                    Spacer()
                    
                    NavigationLink(destination: {
                        
                        OB2()
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
                .frame(height: 220)
                .background(Color("bg2"))
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    OB1()
}
