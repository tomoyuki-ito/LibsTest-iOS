//
//  MasterViewController.swift
//  LibsTest
//
//  Created by Tomoyuki Ito on 2017/11/18.
//  Copyright © 2017 Nagisa Inc. All rights reserved.
//

import UIKit

protocol DetailCreater {
    var title: String { get }
    func instantiate() -> UIViewController
}

class MasterViewController: UITableViewController {

    let items: [DetailCreater] = [
        NormalNetworkCreater(),
        LibsNetworkCreater(),
    ]
    
    var detailViewController: DetailViewController? = nil
    var objects = [Any]()


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table View

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigationController?.pushViewController(items[indexPath.row].instantiate(), animated: true)
    }
    
}

