//
//  AuthManager.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import FirebaseAuth

class AuthManager {
    static let authManager = AuthManager()
    
    static func registerUser(email: String, password: String){
        
    }
    
    static func loginUser(email: String?, username: String?, password: String, completion: @escaping ((Bool) -> Void)){
        if let emailAddress = email {
            Auth.auth().signIn(withEmail: emailAddress, password: password) { authResult, error in
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                    
                completion(true)
            }
        }else if let username = username {
            // login via username
            print(username)
        }
    }
}
