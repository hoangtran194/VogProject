//
//  UserModel.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class UserModel: NSObject, Codable {
    var userName : String?
    var firstName : String?
    var lastName : String?
    var passWord : String?
    var imageURL : String?
    
    private enum CodingKeys : String, CodingKey{
        case userName
        case firstName
        case lastName
        case passWord
        case imageURL
    }
}

///////////////////////////////////////////////////////////////
//MARK: - Functions
///////////////////////////////////////////////////////////////
extension UserModel {
    
    func toDictionary()->[String:AnyObject]
    {
        var result : [String: AnyObject] = [String:AnyObject]()
        
        if userName != nil {
            result["userName"] = userName as AnyObject?
        }
        
        if firstName != nil {
            result["firstName"] = firstName as AnyObject?
        }
        
        if lastName != nil {
            result["lastName"] = lastName as AnyObject?
        }
        
        if passWord != nil {
            result["passWord"] = passWord as AnyObject?
        }
        
        if imageURL != nil {
            result["imageURL"] = imageURL as AnyObject?
        }
        
        return result
    }
    
    /*
     * Function: return whether user is equal to another user or not
     *
     */
    func isEqualToAnotherUser(user : UserModel) -> Bool
    {
        if self.userName == user.userName &&
            self.firstName == user.firstName &&
            self.lastName == user.lastName &&
            self.passWord == user.passWord &&
            self.imageURL == user.imageURL
        {
            return true
        }
        return false
    }
}
