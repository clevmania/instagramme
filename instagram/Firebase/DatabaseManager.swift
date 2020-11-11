//
//  DatabaseManager.swift
//  instagram
//
//  Created by Icelod on 11/10/20.
//  Copyright © 2020 Icelod. All rights reserved.
//

import FirebaseDatabase

class DatabaseManager {
    private static let databaseRef = Database.database().reference().child(Constants.instagramUserRef)
    
    /// checks if user is available
    /// - Parameters
    ///     - email, username
    static func doesUserExist(email: String, username: String, completion: ((Bool) -> Void)){
        completion(true)
    }
    
    /// Insertts new user to database
    /// - Parameters
    ///     - email, username
    ///     - completion: async callback to notify you when a user has sucessfully been created
    static func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        databaseRef.child(email.safeDatabaseKey()).setValue(["username":username]) { error , _ in
            if error == nil {
                // success
                completion(true)
                return
            }else {
                // failed
                completion(false)
                return
            }
        }
    }
}
