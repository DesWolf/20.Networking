//
//  Profile.swift
//  test
//
//  Created by Максим Окунеев on 4/8/20.
//  Copyright © 2020 Максим Окунеев. All rights reserved.
//

import Foundation

struct UserProfile {
    
    let id: Int?
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        let id = data["id"] as? Int
        let name = data["name"] as? String
        let email = data["email"] as? String
        
        self.id = id
        self.name = name
        self.email = email
    }
}
