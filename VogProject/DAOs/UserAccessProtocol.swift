//
//  UserAccessProtocol.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

protocol UserAccessProtocol {
    
    func getUserData(completion : @escaping(Error?,UserModel?)->())
    
    func setUserData(_ userData : UserModel ,completion : @escaping(Error?,UserModel?)->())
    
    func setUserPassword(_ newPassword: String, completion: @escaping (Error?, UserModel?) -> ())
}
