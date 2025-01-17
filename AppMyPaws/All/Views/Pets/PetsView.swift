//
//  PetsView.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct PetsView: View {
    
    @StateObject var viewModel = PetsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Text("Your pets")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)
                
                if viewModel.pets.isEmpty {
                    
                    VStack {
                        
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                        
                        Text("You haven't added your pets yet. Click on «New pet» at the bottom of the screen")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 16) {
                            
                            ForEach(viewModel.pets, id: \.self) {index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedPet = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDelete = true
                                    }
                                    
                                }, label: {
                                    
                                    HStack {
                                        
                                        Image(index.pePhoto ?? "")
                                            .resizable()
                                            .frame(width: 130, height: 130)
                                            .padding(2)
                                            .background(RoundedRectangle(cornerRadius: 20).fill(Color.white.opacity(0.1)))
                                            .padding(2)
                                        
                                        VStack(alignment: .leading, spacing: 11) {
                                            
                                            HStack {
                                                
                                                Text(index.peName ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 20, weight: .semibold))
                                                
                                                Spacer()
                                             
                                                Circle()
                                                    .fill(Color("\(index.peGen ?? "")"))
                                                    .frame(width: 20, height: 20)
                                            }
                                            
                                            Text("\(index.peAnim ?? ""), \(index.peGen ?? "")")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17, weight: .regular))
                                            
                                            Text("\(index.peBreed ?? "")")
                                                .foregroundColor(.white)
                                                .font(.system(size: 17, weight: .regular))
                                            
                                            Text((index.peDate ?? Date()).convertDate(format: "dd.MM.YYYY"))
                                                .foregroundColor(.white)
                                                .font(.system(size: 17, weight: .regular))
                                            
                                            Text(index.peDescr ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 13, weight: .regular))
                                        }
                                    }
                                    .padding(9)
                                    .frame(maxWidth: .infinity)
                                    .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                                })
                            }
                            
                        }
                    }
                }
            }
            .padding()
            
            VStack {
                
                Spacer()
                
                Button(action: {
                    
                    withAnimation(.spring()) {
                        
                        viewModel.isAdd = true
                    }
                    
                }, label: {
                    
                    Text("New pet +")
                        .foregroundColor(.white)
                        .font(.system(size: 15, weight: .regular))
                        .frame(height: 45)
                        .padding(.horizontal, 20)
                        .background(RoundedRectangle(cornerRadius: 30).fill(Color.white.opacity(0.1)))

                })
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchPets()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddPet(viewModel: viewModel)
        })
        .overlay(
            
            ZStack {
                
                Color.black.opacity(viewModel.isDelete ? 0.5 : 0)
                    .ignoresSafeArea()
                    .onTapGesture {
                        
                        withAnimation(.spring()) {
                            
                            viewModel.isDelete = false
                        }
                    }
                
                VStack(spacing: 19) {

                    Text("Delete Pet Card?")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Are you sure you want to delete this pet card? This action cannot be undone.")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(width: 250)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deletePet(withpeName: viewModel.selectedPet?.peName ?? "", completion: {
                                
                                viewModel.fetchPets()
                            })
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Delete")
                                .foregroundColor(.red)
                                .font(.system(size: 18, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                        
                        Button(action: {
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isDelete = false
                            }
                            
                        }, label: {
                            
                            Text("Cancel")
                                .foregroundColor(.white)
                                .font(.system(size: 17, weight: .regular))
                                .frame(maxWidth: .infinity)
                                .frame(height: 45)
                            
                        })
                    }
                    .padding(.top, 25)

                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                .padding()
                .offset(y: viewModel.isDelete ? 0 : UIScreen.main.bounds.height)
            }
        )
    }
}

#Preview {
    PetsView()
}
