//
//  LibsNetworkViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/19.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit
import APIKit

class LibsNetworkCreater: DetailCreater {
    
    let title: String = "LibsNetwork"
    
    func instantiate() -> UIViewController {
        return LibsNetworkViewController(nibName: "LibsNetworkViewController", bundle: nil)
    }
    
}

class LibsNetworkViewController: UIViewController {

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func requestButtonTouched() {
        Session.send(UserRequest()) { (result) in
            switch result {
            case .success(let user):
                print(user)
//                let realmUser = RealmUser()
//                realmUser.id = user.id
//                realmUser.name = user.name
//                realmUser.age = user.age
//                realmUser.save()
                user.save()
                print(RealmUser.allObjects())
            case .failure(let error):
                print(error)
            }
        }
    }

}

struct UserRequest: Request {
    
//    typealias Response = User
//    typealias Response = HimotokiUser
    typealias Response = RealmUser

    let baseURL: URL = URL(string: "http://localhost:3000")!
    var method: HTTPMethod = .get
    var path: String = "/user"

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
//        guard let dict = object as? [String: Any], let user = User(dict: dict) else {
//            throw NSError(domain: "Error", code: 0, userInfo: nil)
//        }
//        return user
//        return try HimotokiUser.decodeValue(object)
        return try RealmUser.decodeValue(object)
    }
    
}
