//
//  ViewController.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-27.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit


class HomeViewController: UIViewController {

    ///////////////////////////////////////////////////////////////
    //MARK: - Properties
    ///////////////////////////////////////////////////////////////
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var userFirstNameLabel: UILabel!
    @IBOutlet weak var userLastNameLabel: UILabel!
    @IBOutlet weak var userUserNameLabel: UILabel!
    @IBOutlet weak var profileView: UIView!
    var userModel : UserModel?
    
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Life cycle
    ///////////////////////////////////////////////////////////////
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        UserAccessAdapter.shared.getUserData { (error, userModel) in
            if error != nil {
                
                var alert : UIAlertController?
                alert = UIAlertController(title: "", message: error.debugDescription, preferredStyle: .alert)
                alert?.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                self.present(alert!, animated: true, completion: nil)
                                
            }else{
                self.userModel = userModel
                self.userFirstNameLabel.text = userModel?.firstName
                self.userLastNameLabel.text = userModel?.lastName
                self.userUserNameLabel.text = userModel?.userName
                UserAccessAdapter.shared.loadImage(imageURL: userModel!.imageURL!, completion: { (error, image) in
                    self.userImage.image = image
                })
            }
        }
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Actions
///////////////////////////////////////////////////////////////
extension HomeViewController{
    @IBAction func editProfileButtonClicked(_ sender: Any) {
        
        let profileEditViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ProfileEditViewController") as! ProfileEditViewController
        profileEditViewController.userModel = self.userModel
        self.navigationController?.pushViewController(profileEditViewController, animated: true)
        
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Private functions
///////////////////////////////////////////////////////////////
extension HomeViewController{
    fileprivate func setupLayout() {
        roundedImage(imageView: self.userImage)
        
        profileView.layer.cornerRadius = 8
        profileView.clipsToBounds = true
    }
}


