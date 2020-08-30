//
//  UserAccessLocal.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class UserAccessLocal: UserAccessProtocol {
    
    static var shared : UserAccessLocal = UserAccessLocal()
    
    /*
    * Function: if user data doesn't have make the dafault and save it to user default then return the user data
    * @param:
    * @return:
    */
    func getUserData(completion: @escaping (Error?, UserModel?) -> ()) {
        let defaults = UserDefaults.standard
        var object = defaults.object(forKey: Constants.kUserObject) as? UserModel
        
        if object == nil {
            object = UserModel()
            object?.initDefaultUser()
            defaults.object(forKey: Constants.kUserObject)
            defaults.synchronize()
        }
        
        completion(nil, object)
    }
    
    /*
    * Function:get user data and set the new value for it then save to user default
    * @param:
    * @return:
    */
    func setUserData(_ userData: UserModel, completion: @escaping (Error?, UserModel?) -> ()) {
        let defaults = UserDefaults.standard
        defaults.set(userData,forKey: Constants.kUserObject)
        defaults.synchronize()
        completion(nil, userData)
    }
    
    
    /*
    * Function:get user data and set the new password for it then save to user default
    * @param:
    * @return:
    */
    func setUserPassword(_ newPassword: String, completion: @escaping (Error?, UserModel?) -> ()) {
        let defaults = UserDefaults.standard
        let object = defaults.object(forKey: Constants.kUserObject) as? UserModel
        
        object?.passWord = newPassword
        defaults.object(forKey: Constants.kUserObject)
        defaults.synchronize()
        
        completion(nil, object)
    }
    
}
