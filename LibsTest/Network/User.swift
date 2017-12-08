//
//  User.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/20.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import Foundation
import Himotoki
import RealmSwift

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

struct HimotokiUser: Himotoki.Decodable {

    let id: Int
    let name: String
    let age: Int
    
    static func decode(_ e: Extractor) throws -> HimotokiUser {
        return try HimotokiUser(
            id: e <| "id",
            name: e <| "name",
            age: e <| "age"
        )
    }
    
}

final class RealmUser: RealmSwift.Object {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var age: Int = 0
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func save() {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(self, update: true)
            }
        } catch let error {
            print("Realm Write Error \(error)")
        }
    }
    
    static func allObjects() -> [RealmUser] {
        do {
            var array: [RealmUser] = []
            let realm = try Realm()
            realm.objects(RealmUser.self).forEach{ array.append($0) }
            return array
        } catch {
            print("Realm Read Error")
            return []
        }
    }
    
}

extension RealmUser: Himotoki.Decodable {

    static func decode(_ e: Extractor) throws -> RealmUser {
        do {
            let user = RealmUser()
            user.id = try e <| "id"
            user.name = try  e <| "name"
            user.age = try  e <| "age"
            return user
        } catch {
            throw Himotoki.DecodeError.custom("Decode Error")
        }
    }

}
