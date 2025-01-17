//
//  AddPet.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct AddPet: View {
    
    @StateObject var viewModel: PetsViewModel
    
    var body: some View {

        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                ZStack {
                    
                    Text("New pet")
                        .foregroundColor(.white)
                        .font(.system(size: 22, weight: .medium))
                    
                    HStack {
                        
                        Spacer()
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Image(systemName: "xmark")
                                .foregroundColor(.white)
                                .font(.system(size: 18, weight: .medium))
                        })
                    }
                }
                .padding(.bottom, 25)
                
                ScrollView(.vertical, showsIndicators: false) {
                    
                    VStack {
                        
                        HStack {
                            
                            Menu(content: {
                                
                                ForEach(viewModel.photos, id: \.self) { index in
                                
                                    Button(action: {
                                        
                                        viewModel.curPhoto = index
                                        
                                    }, label: {
                                        
                                        Image(index)
                                    })
                                }
                                
                            }, label: {
                                
                                if viewModel.curPhoto.isEmpty {
                                    
                                    Image(systemName: "photo")
                                        .foregroundColor(.gray.opacity(0.6))
                                        .font(.system(size: 30, weight: .semibold))
                                        .frame(width: 140, height: 140)
                                        .background(RoundedRectangle(cornerRadius: 15).fill(Color("bg2")))
                                    
                                } else {
                                    
                                    Image(viewModel.curPhoto)
                                        .resizable()
                                        .frame(width: 140, height: 140)
                                }
                            })
                            
                            VStack(alignment: .leading, spacing: 2) {
                                
                                Text("Pet name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                ZStack(content: {
                                    
                                    Text("Enter pet name")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .opacity(viewModel.peName.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.peName)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                    .padding(.bottom, 10)
                                
                                Text("Animal")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                ZStack(content: {
                                    
                                    Text("Enter animal type")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .opacity(viewModel.peAnim.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.peAnim)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                                Text("Breed")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                ZStack(content: {
                                    
                                    Text("Enter animal breed")
                                        .foregroundColor(.gray)
                                        .font(.system(size: 15, weight: .regular))
                                        .opacity(viewModel.peBreed.isEmpty ? 1 : 0)
                                        .frame(maxWidth: .infinity, alignment: .leading)
                                    
                                    TextField("", text: $viewModel.peBreed)
                                        .foregroundColor(Color.white)
                                        .font(.system(size: 16, weight: .regular))
                                    
                                })
                                .padding()
                                .frame(maxWidth: .infinity)
                                
                                Rectangle()
                                    .fill(.gray.opacity(0.5))
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 1)
                                    .padding(.bottom, 10)
                                
                                Text("Pet gender")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                HStack {
                                    
                                    ForEach(viewModel.genders, id: \.self) { index in
                                    
                                        Button(action: {
                                            
                                            viewModel.selGen = index
                                            
                                        }, label: {
                                            
                                            Text(index)
                                                .foregroundColor(.white)
                                                .font(.system(size: 15, weight: .medium))
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 45)
                                                .background(RoundedRectangle(cornerRadius: 30).fill(viewModel.selGen == index ? Color(index) : .gray.opacity(0.2)))
                                        })
                                    }
                                }
                                .padding(.bottom, 10)

                                Text("Date of birth")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                
                                ZStack {
                                    
                                    Color.gray.opacity(0.3)
                                    
                                    DatePicker("", selection: $viewModel.peDate, displayedComponents: .date)
                                        .labelsHidden()
                                        .accentColor(.white)
                                }
                                .padding(.bottom, 10)

                            }
                        }
                        
                        Text("Description (optional)")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("Enter description")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.peDescr.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.peDescr)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.bottom, 50)
                        
                        Button(action: {
                            
                            viewModel.peGen = viewModel.selGen
                            viewModel.pePhoto = viewModel.curPhoto
                            
                            viewModel.addPet()
                            
                            viewModel.peName = ""
                            viewModel.peAnim = ""
                            viewModel.selGen = ""
                            viewModel.curPhoto = ""
                            viewModel.peDescr = ""
                            
                            viewModel.fetchPets()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("+ Add pet")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .medium))
                                .frame(height: 50)
                                .padding(.horizontal, 28)
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color("blue")))
                        })
                        .opacity(viewModel.curPhoto.isEmpty || viewModel.peName.isEmpty || viewModel.peAnim.isEmpty ? 0.3 : 1)
                        .disabled(viewModel.curPhoto.isEmpty || viewModel.peName.isEmpty || viewModel.peAnim.isEmpty ? true : false)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    AddPet(viewModel: PetsViewModel())
}
