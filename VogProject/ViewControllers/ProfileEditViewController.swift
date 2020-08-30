//
//  ProfileEditViewController.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-30.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import SwiftUI

class ProfileEditViewController: UIViewController {
    
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userUserNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userPassWordTextField: UITextField!
    @IBOutlet weak var userPassWordConfirmationTextField: UITextField!
    
    var userModel : UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        userFirstNameTextField.text = userModel?.firstName
        userLastNameTextField.text = userModel?.lastName
        userUserNameTextField.text = userModel?.userName
        userPassWordTextField.text = userModel?.passWord
     
        UserAccessAdapter.shared.loadImage(imageURL: (userModel!.imageURL)!) { (error, image) in
            if image != nil{
                self.userImage.image = image
            }
        }
    }
    
    fileprivate func setupLayout() {
        roundedImage(imageView: self.userImage)
    }
    
}

