//
//  LibsAsyncViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/20.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit
import BrightFutures

class LibsAsyncViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func readComic() {
        rental().flatMap { (result) -> Future<Bool, NSError> in
            print("1 \(result)")
            return self.download()
            }.flatMap { (result) -> Future<Bool, NSError> in
                print("2 \(result)")
                return self.unzip()
            }.onSuccess { (result) in
                print("3 \(result)")
            }.onFailure { (error) in
                print("4 \(error)")
            }.onComplete { (result) in
                print("5 \(result)")
        }
    }
    
    func rental() -> Future<Bool, NSError> {
        let promise = Promise<Bool, NSError>()
        promise.success(true)
        return promise.future
    }
    
    func download() -> Future<Bool, NSError> {
        let promise = Promise<Bool, NSError>()
        promise.failure(NSError(domain: "Error", code: 0, userInfo: nil))
        return promise.future
    }
    
    func unzip() -> Future<Bool, NSError> {
        let promise = Promise<Bool, NSError>()
        promise.success(true)
        return promise.future
    }

}
