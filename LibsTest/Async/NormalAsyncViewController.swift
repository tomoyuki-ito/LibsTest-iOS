//
//  NormalAsyncViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/20.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit

class NormalAsyncViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func readBook() {
        rental { (result, error) in
            guard result else { return }
            download(completion: { (result, error) in
                guard result else { return }
                unzip(completion: { (result, error) in
                    guard result else { return }
                })
            })
        }
    }
    
    func rental(completion: (Bool, NSError) -> Void) {
    }
    
    func download(completion: (Bool, NSError) -> Void) {
    }
    
    func unzip(completion: (Bool, NSError) -> Void) {
    }
    
}
