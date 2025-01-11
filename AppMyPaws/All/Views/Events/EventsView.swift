//
//  EventsView.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct EventsView: View {

    @StateObject var viewModel = EventsViewModel()
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            VStack {
                
                Text("Events")
                    .foregroundColor(.white)
                    .font(.system(size: 32, weight: .medium))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 40)
                
                if viewModel.events.isEmpty {
                    
                    VStack {
                        
                        Image("empty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 170)
                        
                        Text("You don't have any events planned for your pets yet. Click on «New event» at the bottom of the screen.")
                            .foregroundColor(.white)
                            .font(.system(size: 15, weight: .regular))
                            .frame(width: 250)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                    
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false) {
                        
                        LazyVStack(spacing: 16) {
                            
                            ForEach(viewModel.events, id: \.self) {index in
                            
                                Button(action: {
                                    
                                    viewModel.selectedEvent = index
                                    
                                    withAnimation(.spring()) {
                                        
                                        viewModel.isDelete = true
                                    }
                                    
                                }, label: {
                                    
                                    VStack(alignment: .leading, spacing: 11) {
                                                                                   
                                                Text(index.evName ?? "")
                                                    .foregroundColor(.white)
                                                    .font(.system(size: 20, weight: .semibold))

                                            Text((index.evDate ?? Date()).convertDate(format: "dd.MM.YYYY"))
                                                .foregroundColor(.white)
                                                .font(.system(size: 17, weight: .regular))
                                        
                                        Text((index.evTime ?? Date()).convertDate(format: "HH:MM"))
                                            .foregroundColor(.white)
                                            .font(.system(size: 17, weight: .regular))
                                        
                                        Text("Pet")
                                            .foregroundColor(.white)
                                            .font(.system(size: 14, weight: .regular))
                                        
                                        HStack {
                                            
                                            Image(index.evPetPhoto ?? "")
                                                .resizable()
                                                .aspectRatio(contentMode: .fit)
                                                .frame(width: 50)
                                            
                                            Text(index.evPet ?? "")
                                                .foregroundColor(.white)
                                                .font(.system(size: 16, weight: .regular))
                                        }

                                    }
                                    .padding()
                                    .frame(maxWidth: .infinity, alignment: .leading)
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
                    
                    Text("New event +")
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
            
            viewModel.fetchEvents()
        }
        .sheet(isPresented: $viewModel.isAdd, content: {
            
            AddEvent(viewModel: viewModel)
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

                    Text("Delete Event Card?")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .semibold))
                        .multilineTextAlignment(.center)
                    
                    Text("Are you sure you want to delete this event card? This action cannot be undone.")
                        .foregroundColor(.white)
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.center)
                        .frame(width: 250)
                    
                    HStack {
                        
                        Button(action: {
                            
                            CoreDataStack.shared.deleteEvent(withEvName: viewModel.selectedEvent?.evName ?? "", completion: {
                                
                                viewModel.fetchEvents()
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
                                .foregroundColor(.blue)
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
    EventsView()
}
