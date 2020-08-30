//
//  ProfileEditViewController.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-30.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import SwiftUI

class ProfileEditViewController: UIViewController{
    
///////////////////////////////////////////////////////////////
//MARK: - Properties
///////////////////////////////////////////////////////////////
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFirstNameTextField: UITextField!
    @IBOutlet weak var userUserNameTextField: UITextField!
    @IBOutlet weak var userLastNameTextField: UITextField!
    @IBOutlet weak var userPassWordTextField: UITextField!
    @IBOutlet weak var userPassWordConfirmationTextField: UITextField!
    
    @IBOutlet weak var passWordView: UIView!
    @IBOutlet weak var profileView: UIView!
    var imagePicker = UIImagePickerController()
    var userModel : UserModel?
    
    
///////////////////////////////////////////////////////////////
//MARK: - Life cycle
///////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Private functions
///////////////////////////////////////////////////////////////
extension ProfileEditViewController{
    fileprivate func setupLayout() {
        roundedImage(imageView: self.userImage)
        profileView.layer.cornerRadius = 8
        profileView.clipsToBounds = true
        passWordView.layer.cornerRadius = 8
        passWordView.clipsToBounds = true
    }
    
    fileprivate func loadData() {
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
    
    fileprivate func updateUserProfile() {
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
    }
    
    fileprivate func updateUserPassWord() {
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
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Actions
///////////////////////////////////////////////////////////////
extension ProfileEditViewController{
    
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        
        if isTextValid(text: userFirstNameTextField.text) &&
            isTextValid(text: userLastNameTextField.text)
        {
            
            userModel?.firstName = userFirstNameTextField.text
            userModel?.lastName = userLastNameTextField.text
            updateUserProfile()
            
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
            updateUserPassWord()
            
        }else{
            
            var alert : UIAlertController?
            alert = UIAlertController(title: "", message: "Please input correct password and password confirmation", preferredStyle: .alert)
            alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert!, animated: true, completion: nil)

        }
    }
        
    @IBAction func changeProfilePictureButtonClicked(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            print("Button capture")

            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Image Picker Delegate
///////////////////////////////////////////////////////////////
extension ProfileEditViewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        picker.dismiss(animated: true, completion: nil)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return
        }
        
        
        UserAccessAdapter.shared.saveImage(image: image) { (error, imagePath) in
            if error == nil{
                var alert : UIAlertController?
                alert = UIAlertController(title: "", message: "Image's chnaged successfully", preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert!, animated: true, completion: nil)
                self.userImage.image = image
            }else{
                var alert : UIAlertController?
                alert = UIAlertController(title: "", message: "Image's changed failed", preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert!, animated: true, completion: nil)
            }
            
        }
    }
}
