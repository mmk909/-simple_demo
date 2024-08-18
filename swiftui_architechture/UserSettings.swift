//
//  UserSettings.swift
//  swiftui_architechture
//
//  Created by michael on 2024/8/18.
//

import SwiftUI
import Combine
import Keychain


class UserSettings: ObservableObject {
    
    static let shared = UserSettings()
    
    @Published public var showLogin: Bool = false
    @Published private var _userToken: String = ""


    @Keychain(Keys.userToken)
    private var secureUserToken: String?


    var userToken: String {
        get {
            return _userToken
        }
        set {
            if !newValue.isEmpty {
                secureUserToken = newValue
                _userToken = secureUserToken ?? ""
            } else {
                secureUserToken = ""
                _userToken = secureUserToken ?? ""
            }
        }
    }
    
    private init(username: String = "", isLoggedIn: Bool = false) {
        self.userToken = self.secureUserToken ?? ""
    }
}
