//
//  Constants.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit

class Constants: NSObject {
    ///////////////////////////////////////////////////////////////
    //MARK: - API
    ///////////////////////////////////////////////////////////////
    static let baseUrl              = "https://api.foo.com/"
    static let getProfile           = baseUrl + "/profiles/mine"
    static let updateProfile        = baseUrl + "/profiles/update"
    static let updatePassWord       = baseUrl + "/password/change"
    
    ///////////////////////////////////////////////////////////////
    //MARK: - Others
    ///////////////////////////////////////////////////////////////
    static let emptyValue           = ""
    static let kToken               = "kToken"
    static let kTokenValue          = "TokenGottenFromJWT"
    static let kUserObject          = "kUserObject"
    
    
    static let kUserFirstName      = "Hoang"
    static let kUserLastName       = "Tran"
    static let kUserUserName       = "hoangtran194"
    static let kUserPassWord       = "HoangPassWord@1"
    static let kUserImageURL       = ""
    
}
