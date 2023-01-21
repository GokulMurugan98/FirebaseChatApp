//
//  DatabaseManager.swift
//  FireBaseApp
//
//  Created by Gokul Murugan on 2023-01-21.
//

import Foundation
import Firebase


final class DatabaseManager{
    
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    
    
    public func createUser(with user:User){
        
        let safe =  user.email.replacingOccurrences(of: ".", with: "-")
        database.child(safe).setValue(["firstName":user.firstName, "lastName":user.lastName])

        
    }
    
}

struct User{
    let email:String
    let firstName:String
    let lastName:String
    
}
