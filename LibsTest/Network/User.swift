//
//  User.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/20.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import Foundation

struct User {
    
    let id: Int
    let name: String
    let age: Int
    
    init?(dict: [String: Any]) {
        guard let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let age = dict["age"] as? Int else {
                return nil
        }
        self.id = id
        self.name = name
        self.age = age
    }
    
}
