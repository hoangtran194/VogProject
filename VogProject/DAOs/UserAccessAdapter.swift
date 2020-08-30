//
//  UserAccessAdapter.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-30.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit


enum AccessType {
  case API
  case Local
}

class UserAccessAdapter: UserAccessProtocol {        
    
    static var shared : UserAccessAdapter = UserAccessAdapter(type: .Local)
    var type : AccessType = .Local
    var userAccessProtocol : UserAccessProtocol?
    
    init(type: AccessType) {
        changeType(type: type)
    }
    
    func changeType(type : AccessType) {
        if type == .Local {
            userAccessProtocol = UserAccessLocal.shared
        }else{
            userAccessProtocol = UserAccessAPI.shared
        }
    }
    
    func getUserData(completion: @escaping (Error?, UserModel?) -> ()) {        
        userAccessProtocol?.getUserData(completion: completion)
    }
    
    func setUserData(_ userData: UserModel, completion: @escaping (Error?, UserModel?) -> ()) {
        userAccessProtocol?.setUserData(userData, completion: completion)
    }
    
    func setUserPassword(_ newPassword: String, completion: @escaping (Error?, UserModel?) -> ()) {
        userAccessProtocol?.setUserPassword(newPassword, completion: completion)
    }
    
}
