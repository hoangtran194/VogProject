//
//  UserAccessLocal.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class UserAccessLocal: UserAccessProtocol {
    func getUserData() -> UserModel {
        return UserModel()
    }
    
    func setUserData() -> Bool {
        return true
    }
    
    func setUserImage(imageData: UIImage) -> Bool {
        return true
    }
}
