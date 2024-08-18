//
//  ProfileView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI
import SDWebImageSwiftUI


struct ProfileView: View {
    @StateObject private var userSettings = UserSettings.shared
    // Sample profile data with image URL
    private var profile = ProfileModel(
        username: "JohnDoe",
        email: "john.doe@example.com",
        profilePictureURL: URL(string: "https://avatars.githubusercontent.com/u/18080140?v=4&size=64")
    )

    var body: some View {
        NavigationView {
            
            VStack {
                if userSettings.userToken.isEmpty{
                    // Login Button
                    Button(action: {
                        userSettings.showLogin.toggle()
                    }) {
                        Text("Login")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color(UIColor.systemBlue))
                            .foregroundColor(Color(UIColor.systemBackground))
                            .cornerRadius(8)
                    }
                    .padding()
                }
                else {
                    // Profile Picture
                    if let profilePictureURL = profile.profilePictureURL {
                        WebImage(url: profilePictureURL)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .shadow(radius: 10)
                            .padding()
                    } else {
                        // Placeholder for missing profile picture
                        Circle()
                            .fill(Color.gray)
                            .frame(width: 100, height: 100)
                            .overlay(Text("No Image").foregroundColor(.white))
                            .padding()
                    }
                    
                    // Username
                    Text(profile.username)
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    
                    // Email
                    Text(profile.email)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                        .padding()
                    
                    // Logout Button
                    Button(action: {
                        userSettings.userToken = ""
                    }) {
                        Text("Logout")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                    .padding()
                    Spacer()
                    
                }
                
            }
            .navigationTitle("Profile")
        }

    }

}


extension ProfileView {
    struct ProfileModel {
        var username: String
        var email: String
        var profilePictureURL: URL? // URL for the profile picture
    }
}
