//
//  UserModel.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class UserModel: NSObject, Codable, NSCoding , NSSecureCoding{
    static var supportsSecureCoding: Bool = true
    
    override init() {
        
    }
    
    init(userName: String?,
         firstName: String?,
         lastName : String?,
         imageURL: String?,
         passWord : String?) {
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.imageURL = imageURL
        self.passWord = passWord
    }
    
    required init?(coder: NSCoder) {
        self.userName = coder.decodeObject(forKey: "userName") as? String
        self.firstName = coder.decodeObject(forKey: "firstName") as? String
        self.lastName = coder.decodeObject(forKey: "lastName") as? String
        self.imageURL = coder.decodeObject(forKey: "imageURL") as? String
        self.passWord = coder.decodeObject(forKey: "passWord") as? String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(self.userName, forKey: "userName")
        coder.encode(self.firstName, forKey: "firstName")
        coder.encode(self.lastName, forKey: "lastName")
        coder.encode(self.passWord, forKey: "passWord")
        coder.encode(self.imageURL, forKey: "imageURL")
    }

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
    
    func copy(userModel: UserModel) -> UserModel
    {
        return UserModel(userName: userModel.userName,
                         firstName: userModel.firstName,
                         lastName: userModel.lastName,
                         imageURL: userModel.imageURL,
                         passWord: userModel.passWord)
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
    
    
    /*
     * Function: return whether user is equal to another user or not
     *
     */
    func initDefaultUser()
    {
        self.firstName  = Constants.kUserFirstName
        self.lastName   = Constants.kUserLastName
        self.userName   = Constants.kUserUserName
        self.passWord   = Constants.kUserPassWord
        self.imageURL   = Constants.kUserImageURL
    }
    
}
