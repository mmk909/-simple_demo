//
//  ContentView.swift
//  swiftui_architechture
//
//  Created by michael on 2023/9/17.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var userSettings = UserSettings.shared
    
    @State private var selection = 0

    var body: some View {
            TabView(selection: $selection) {
                
                    HomeView()
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }.tag(0)
                    SearchView()
                        .tabItem {
                            Image(systemName: "magnifyingglass")
                            Text("Search")
                        }.tag(1)
                    ProfileView()
                        .tabItem {
                            Image(systemName: "person.crop.circle")
                            Text("Profile")
                        }.tag(2)
                }
            .fullScreenCover(isPresented: $userSettings.showLogin) {
                LoginView()
            }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
