//
//  AddEvent.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct AddEvent: View {
    
    @StateObject var viewModel: EventsViewModel
    
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
                        
                        VStack(alignment: .leading, spacing: 2) {
                            
                            Text("Event name")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                            
                            ZStack(content: {
                                
                                Text("Enter pet name")
                                    .foregroundColor(.gray)
                                    .font(.system(size: 15, weight: .regular))
                                    .opacity(viewModel.evName.isEmpty ? 1 : 0)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                TextField("", text: $viewModel.evName)
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
                            
                            Text("Date and Time")
                                .foregroundColor(.white)
                                .font(.system(size: 15, weight: .regular))
                            
                            HStack {
                                
                                ZStack {
                                    
                                    Color.gray.opacity(0.3)
                                    
                                    DatePicker("", selection: $viewModel.evDate, displayedComponents: .date)
                                        .labelsHidden()
                                        .accentColor(.white)
                                }
                                
                                ZStack {
                                    
                                    Color.gray.opacity(0.3)
                                    
                                    DatePicker("", selection: $viewModel.evTime, displayedComponents: .hourAndMinute)
                                        .labelsHidden()
                                        .accentColor(.white)
                                }
                            }
                            .padding(.bottom, 10)
                        }
                        
                        Rectangle()
                            .fill(.gray.opacity(0.5))
                            .frame(maxWidth: .infinity)
                            .frame(height: 1)
                            .padding(.bottom, 10)
                        
                        ScrollView(.vertical, showsIndicators: false) {
                            
                            LazyVStack {
                                
                                Text("Pets")
                                    .foregroundColor(.white)
                                    .font(.system(size: 15, weight: .regular))
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                
                                ForEach(viewModel.pets, id: \.self) { index in
                                    
                                    Button(action: {
                                        
                                        viewModel.selectedPet = index
                                        
                                    }, label: {
                                        
                                        HStack {
                                            
                                            Image(index.pePhoto ?? "")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50)
                                            
                                            Text(index.peName ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 18, weight: .medium))
                                            
                                            Spacer()
                                            
                                            ZStack {
                                                
                                                RoundedRectangle(cornerRadius: 5)
                                                    .stroke(Color.gray, lineWidth: 2)
                                                    .frame(width: 20, height: 20)
                                                    .padding(2)
                                                
                                                Image(systemName: "checkmark")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 13, weight: .medium))
                                                    .opacity(viewModel.selectedPet == index ? 1 : 0)
                                            }
                                        }
                                    })
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(RoundedRectangle(cornerRadius: 20).fill(Color("bg2")))
                        .padding(.bottom)
                        
                        Text("Description")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        ZStack(content: {
                            
                            Text("Enter description")
                                .foregroundColor(.gray)
                                .font(.system(size: 15, weight: .regular))
                                .opacity(viewModel.evDescr.isEmpty ? 1 : 0)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            
                            TextField("", text: $viewModel.evDescr)
                                .foregroundColor(Color.white)
                                .font(.system(size: 16, weight: .regular))
                            
                        })
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding(.bottom, 50)
                        
                        Button(action: {
                            
                            viewModel.evPetPhoto = viewModel.selectedPet?.pePhoto ?? ""
                            viewModel.evPet = viewModel.selectedPet?.peName ?? ""
                            
                            viewModel.addEvent()
                            
                            viewModel.evName = ""
                            
                            viewModel.fetchEvents()
                            
                            withAnimation(.spring()) {
                                
                                viewModel.isAdd = false
                            }
                            
                        }, label: {
                            
                            Text("Save and close\(Image(systemName: "checkmark"))")
                                .foregroundColor(.black)
                                .font(.system(size: 15, weight: .medium))
                                .frame(height: 50)
                                .padding(.horizontal, 28)
                                .background(RoundedRectangle(cornerRadius: 30).fill(Color.white))
                        })
                        .opacity(viewModel.evName.isEmpty ? 0.3 : 1)
                        .disabled(viewModel.evName.isEmpty ? true : false)
                    }
                }
            }
            .padding()
        }
        .onAppear {
            
            viewModel.fetchPets()
        }
    }
}

#Preview {
    AddEvent(viewModel: EventsViewModel())
}
