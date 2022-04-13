//
//  UserSingleton.swift
//  SnapChatCloneWithFirebase
//
//  Created by Ali Osman DURMAZ on 8.04.2022.
//

import Foundation

class UserSingleton {
    
    static let sharedUserInfo = UserSingleton()
    
    var email = ""
    var username = ""
    
    private init() {
        
    }
}
