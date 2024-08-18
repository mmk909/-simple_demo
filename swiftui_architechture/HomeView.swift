//
//  HomeView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Welcome Message
                Text("Welcome to the App!")
                    .font(.largeTitle)
                    .padding()

                Spacer()
            }
            .navigationTitle("Home")
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

