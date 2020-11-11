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
    
    static func registerUser(username: String, email: String, password: String, completion: @escaping (Bool) -> Void){
        DatabaseManager.doesUserExist(email: email, username: username) { userExists in
            if userExists {
                // Creates an account
                Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                    guard error == nil , result != nil else {
                        // Account could not be created
                        completion(false)
                        return
                    }
                    // Insert into database
                    DatabaseManager.insertNewUser(with: email, username: username) { isInserted in
                        if isInserted {
                            completion(true)
                            return
                        }else {
                            completion(false)
                            return
                        }
                    }
                }
            }else{
                // user doesn't exist
                completion(false)
            }
        }
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
