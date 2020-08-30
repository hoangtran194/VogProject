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
    
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        
        if isTextValid(text: userFirstNameTextField.text) &&
            isTextValid(text: userLastNameTextField.text)
        {
            userModel?.firstName = userFirstNameTextField.text
            userModel?.lastName = userLastNameTextField.text
            
            UserAccessAdapter.shared.setUserData(userModel!) { (error, newUserModel) in
                var alert : UIAlertController?
                if error == nil {
                    alert = UIAlertController(title: "", message: "User's updated successfully", preferredStyle: .alert)
                }else{
                    alert = UIAlertController(title: "", message: "User's updated failed", preferredStyle: .alert)
                }
                
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert!, animated: true, completion: nil)
            }
        }else{
            var alert : UIAlertController?
            alert = UIAlertController(title: "", message: "Please input user first name and last name", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert!, animated: true, completion: nil)

        }
        
    }
    
    @IBAction func changePassWordButtonClicked(_ sender: Any) {

        
        
        if isTextValid(text: userPassWordTextField.text) &&
            isTextValid(text: userPassWordConfirmationTextField.text) &&
            (userPassWordConfirmationTextField.text == userPassWordTextField.text)
        {
            userModel?.passWord = userPassWordTextField.text
            UserAccessAdapter.shared.setUserPassword(userModel!.passWord!) { (error, userModel) in
                var alert : UIAlertController?
                if error == nil {
                    alert = UIAlertController(title: "", message: "Password's updated successfully", preferredStyle: .alert)
                }else{
                    alert = UIAlertController(title: "", message: "Password's updated failed", preferredStyle: .alert)
                }
                
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert!, animated: true, completion: nil)
            }
        }else{
            var alert : UIAlertController?
            alert = UIAlertController(title: "", message: "Please input correct password and password confirmation", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert!, animated: true, completion: nil)

        }
        
        
    }
}

