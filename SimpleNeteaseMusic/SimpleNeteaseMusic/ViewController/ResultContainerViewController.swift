//
//  ResultContainerViewController.swift
//  SimpleNeteaseMusic
//
//  Created by shenjie on 2020/9/14.
//  Copyright © 2020 shenjie. All rights reserved.
//

import UIKit

class ResultContainerViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }
    
}
