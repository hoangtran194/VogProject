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
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userUserNameLabel: UILabel!
    
    var userModel : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserAccessAdapter.shared.getUserData { (error, userModel) in
            if error != nil {
                //Should show the alert view instead of print the issue only
                print(error!)
                
            }else{
                self.userModel = userModel
                self.userFirstNameLabel.text = userModel?.firstName
                self.userLastNameLabel.text = userModel?.lastName
                self.userUserNameLabel.text = userModel?.userName
                self.userImage.image = loadImage(fileName: userModel!.imageURL!)
            }
        }
    }
    
    fileprivate func setupLayout() {                
        roundedImage(imageView: self.userImage)
    }
    
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        
        let profileEditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileEditViewController") as! ProfileEditViewController
        profileEditViewController.userModel = self.userModel
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
        
    }
    
}

