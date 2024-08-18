//
//  CircleImageView.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//


import SwiftUI
import SDWebImageSwiftUI

struct CircleImageView: View {
    
    var imgUrl: String?
    var size: CGFloat = 48.0
    
    var body: some View {
        
        if let url = URL(string: imgUrl!) {
            WebImage(
                url: url
            )
            .resizable()
            .frame(width: size, height: size)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
        }
        
        
        //        Image(systemName: img)
        //            .resizable()
        //            .frame(width: size, height: size)
        //            .clipShape(Circle())
        //            .overlay(Circle().stroke(Color.white, lineWidth: 2))
        //            .shadow(radius: 5)
        
    }
}

struct CircleImageView_Previews: PreviewProvider {
    static var previews: some View {
        CircleImageView()
    }
}
