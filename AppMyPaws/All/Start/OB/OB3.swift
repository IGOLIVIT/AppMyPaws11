//
//  OB3.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct OB3: View {
    
    @AppStorage("status") var status: Bool = false
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Image("ob3")
                    .resizable()
                    .ignoresSafeArea()
            }
            
            VStack {
                
                Spacer()
                
                VStack {
                    
                    Text("Set a date and time for events")
                        .foregroundColor(.white)
                        .font(.system(size: 28, weight: .semibold))
                    
                    Spacer()
                    
                    Button(action: {
                        
                        status = true
                        
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
    OB3()
}
