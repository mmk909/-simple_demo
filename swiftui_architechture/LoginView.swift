//
//  LoginView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI
import LocalAuthentication


struct LoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @AppStorage(Keys.isLogin) private var isLogin: Bool = false
    // State variables to hold the input values
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isShowingAlert: Bool = false
    @State private var alertMessage: String = ""
    @State private var isPasswordVisible: Bool = false
    @StateObject private var userSettings = UserSettings.shared

    // Function to handle login
    private func handleLogin() {
        userSettings.userToken = ""
        // Basic validation
        guard !username.isEmpty, !password.isEmpty else {
            alertMessage = "Please enter both username and password."
            isShowingAlert = true
            return
        }

        // Simulate a login process
        // In a real application, you would typically make a network request here
        if username == "testuser" && password == "password123" {
            alertMessage = "Login successful!"
            userSettings.userToken = "passwordtoken"
        } else {
            alertMessage = "Invalid username or password."
        }
        isShowingAlert = true
    }
    
    private func handleFaceLogin() {
        let context = LAContext()
        var error: NSError?

        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "Please authenticate yourself to unlock your places."

            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in

                if success {
                    alertMessage = "Login successful!"
                    userSettings.userToken = "facelogintoken"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        // Simulate some processing time, then dismiss
                        presentationMode.wrappedValue.dismiss()
                    }
                    
                } else {
                    // error
                    alertMessage = "Login failed!"
                }
            }
        } else {
            // no biometrics
            alertMessage = "no biometrics!"
        }
        
        isShowingAlert = true

        
    }

    var body: some View {
        NavigationView {
            VStack {
                // Logo or Title
                Text("Login")
                    .font(.largeTitle)
                    .padding()

                // Username TextField
                TextField("Username", text: $username)
                    .padding()
                    .autocapitalization(.none) // Prevents automatic capitalization
                    .background(Color(UIColor.secondarySystemBackground))
                    .cornerRadius(8)
                    .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(UIColor.separator), lineWidth: 1))
                    .padding(.horizontal)

                // Password SecureField
//                SecureField("Password", text: $password)
                //                    .padding()
                //                    .background(Color(UIColor.secondarySystemBackground))
                //                    .cornerRadius(8)
                //                    .overlay(RoundedRectangle(cornerRadius: 8)
                //                                .stroke(Color(UIColor.separator), lineWidth: 1))
                //                    .padding(.horizontal)
                HStack {
                if isPasswordVisible {
                        TextField("Password", text: $password)
                            .padding()
                            .autocapitalization(.none) // Prevents automatic capitalization
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(UIColor.separator), lineWidth: 1))
                    } else {
                        SecureField("Password", text: $password)
                            .padding()
                            .background(Color(UIColor.secondarySystemBackground))
                            .cornerRadius(8)
                            .overlay(RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(UIColor.separator), lineWidth: 1))
                    }
                    
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                            .foregroundColor(.gray)
                            .padding()
                    }
                }
                .padding()

                // Login Button
                Button(action: handleLogin) {
                    Text("Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemBlue))
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                }
                .padding()
                
                // Login Button
                Button(action: handleFaceLogin) {
                    Text("Face Login")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemIndigo))
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                }
                .padding()

//                // Face Login Button
//                NavigationLink(destination: FaceLoginView(isPresented: $isPresented)) {
//                    Text("Face Login")
//                        .frame(maxWidth: .infinity)
//                        .padding()
//                        .background(Color(UIColor.systemIndigo))
//                        .foregroundColor(Color(UIColor.systemBackground))
//                        .cornerRadius(8)
//                }
//                .padding()
                
//                NavigationLink("Go to Profile", destination: ProfileView())
//                                   .padding()
//                                   .background(Color.blue)
//                                   .foregroundColor(.white)
//                                   .cornerRadius(8)

                Spacer()
                
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color(UIColor.systemGray))
                        .foregroundColor(Color(UIColor.systemBackground))
                        .cornerRadius(8)
                }
            }
            .background(Color(UIColor.systemBackground))
            .padding()
            .alert(isPresented: $isShowingAlert) {
                Alert(title: Text("Login"), 
                      message: Text(alertMessage),
                      dismissButton: .default(Text("OK"),
                     action: {
                        // Dismiss the current view after clicking "OK"
                        presentationMode.wrappedValue.dismiss()
                        userSettings.showLogin = false
                    }))
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            LoginView()
            LoginView()
                .environment(\.colorScheme, .dark)
        }
    }
}




