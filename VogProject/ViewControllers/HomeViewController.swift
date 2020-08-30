//
//  ViewController.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-27.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserAccessAdapter.shared.getUserData { (error, userModel) in
            
        }
    }
}

