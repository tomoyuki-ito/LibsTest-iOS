//
//  NormalNetworkViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/18.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit

class NormalNetworkCreater: DetailCreater {
    let title: String = "NormalNetwork"
    func instantiate() -> UIViewController {
        return NormalNetworkViewController(nibName: "NormalNetworkViewController", bundle: nil)
    }
}

class NormalNetworkViewController: UIViewController {

    @IBOutlet weak var stateLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func requestButtonTouched() {
        let url = URL(string: "http://localhost:3000/user")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    guard let dict = json  as? [String: Any], let user = User(dict: dict) else {
                            print("Serialize Error")
                            return
                    }
                    print(user)
                } catch {
                    print("Serialize Error")
                }
            } else {
                print(error ?? "Error")
            }
        }
        task.resume()
    }
    
}

