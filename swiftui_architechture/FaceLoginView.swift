//
//  FaceLoginView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI

struct FaceLoginView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool // Binding to control dismissal

    var body: some View {
        VStack {
            Text("Face Login")
                .font(.largeTitle)
                .padding()

            // Add content for face login, such as instructions or a placeholder view
            Text("Face login functionality goes here.")
                .padding()
            
            // Login Button
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Go Back")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.systemBlue))
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(8)
            }
            .padding()

            Spacer()
            
            Button(action: {
                isPresented = false
            }) {
                Text("Cancel")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color(UIColor.systemGray))
                    .foregroundColor(Color(UIColor.systemBackground))
                    .cornerRadius(8)
            }
        }
        .navigationTitle("Face Login")
    }
}

