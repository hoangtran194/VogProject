//
//  UserDefaultManager.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-30.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import SwiftUI

func saveUserDataToUserDefault(userData : UserModel) ->Bool{
    do {
        let encodedData = try NSKeyedArchiver.archivedData(withRootObject: userData, requiringSecureCoding: false)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedData, forKey: Constants.kUserObject)
        userDefaults.synchronize()
        return true
    } catch {
        return false
    }
}

func getUserDataFromUserDefault()->UserModel?{
    let decoded  = UserDefaults.standard.object(forKey: Constants.kUserObject) as? Data
    
    if decoded == nil {
        return nil
    }
    
    do {
        let userObject = try NSKeyedUnarchiver.unarchivedObject(ofClass: UserModel.self, from: decoded!)
        return userObject
    } catch {
        return nil
    }
}
