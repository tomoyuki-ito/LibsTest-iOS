//
//  LibsNetworkViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/19.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit
import APIKit
import BrightFutures

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
//        APIKit.Session.send(UserRequest()) { (result) in
//            switch result {
//            case .success(let user):
//                print(user)
////                let realmUser = RealmUser()
////                realmUser.id = user.id
////                realmUser.name = user.name
////                realmUser.age = user.age
////                realmUser.save()
//                user.save()
//                print(RealmUser.allObjects())
//            case .failure(let error):
//                print(error)
//            }
//        }
        downloadSequence()
    }

    func comic(comicId: Int) -> Future<String, NSError> {
        let promise = Promise<String, NSError>()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
//            promise.success("https://manga.com/manga.zip")
            promise.failure(NSError(domain: "", code: 0, userInfo: nil))
        }
        return promise.future
    }
    
    func download(url: String) -> Future<String, NSError> {
        let promise = Promise<String, NSError>()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            promise.success("file:///temp/manga.zip")
        }
        return promise.future
    }
    
    func unzip(filePath: String) -> Future<String, NSError> {
        let promise = Promise<String, NSError>()
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            promise.success("file:///temp/mangaFiles")
        }
        return promise.future
    }

    func downloadSequence() -> Future<String, NSError> {
        let promise = Promise<String, NSError>()
        comic(comicId: 100)
            .flatMap { (url) -> Future<String, NSError> in
                return self.download(url: url)
            }.flatMap { (zipPath) -> Future<String, NSError> in
                return self.unzip(filePath: zipPath)
            }.onSuccess(callback: { (mangaPath) in
                promise.success(mangaPath)
            }).onFailure { (error) in
                promise.failure(error)
        }
        return promise.future
    }

}

struct UserRequest: APIKit.Request {
    
//    typealias Response = User
//    typealias Response = HimotokiUser
    typealias Response = RealmUser

    let baseURL: URL = URL(string: "http://localhost:3000")!
    var method: HTTPMethod = .get
    var path: String = "/user"

    func response(from object: Any,
                  urlResponse: HTTPURLResponse) throws -> Response {
//        guard let dict = object as? [String: Any], let user = User(dict: dict) else {
//            throw NSError(domain: "Error", code: 0, userInfo: nil)
//        }
//        return user
//        return try HimotokiUser.decodeValue(object)
        return try RealmUser.decodeValue(object)
    }
    
}
