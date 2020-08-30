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
        
        var object = getUserDataFromUserDefault()
        
        if object == nil {
            object = UserModel()
            object?.initDefaultUser()
                        
            let profileImage = UIImage(named: Constants.kdefaultImageName)!
            saveImage(image: profileImage) { (error, filePath) in
                let imagePath = filePath
                object?.imageURL = imagePath
                _ = saveUserDataToUserDefault(userData: object!)
                
                completion(nil, object)
            }
        }else{
            completion(nil, object)
        }        
    }
    
    /*
    * Function:get user data and set the new value for it then save to user default
    * @param:
    * @return:
    */
    func setUserData(_ userData: UserModel, completion: @escaping (Error?, UserModel?) -> ()) {
        _ = saveUserDataToUserDefault(userData: userData)
        completion(nil, userData)
    }
    
    
    /*
    * Function:get user data and set the new password for it then save to user default
    * @param:
    * @return:
    */
    func setUserPassword(_ newPassword: String, completion: @escaping (Error?, UserModel?) -> ()) {
        getUserData { (error, userModel) in
            userModel?.passWord = newPassword
            _ = saveUserDataToUserDefault(userData: userModel!)
            completion(nil, userModel)
        }
    }
    
    
    /*
    * Function:Load the local image file from file name
    * @param:
    * @return:
    */
    func loadImage(imageURL: String, completion: @escaping (Error?, UIImage?) -> ()) {
        let fileURL = documentsUrl.appendingPathComponent(imageURL)
        do {
            let imageData = try Data(contentsOf: fileURL)
            completion(nil, UIImage(data: imageData))
        } catch {
            completion( NetworkError.unKnown("Can not get the image file"), nil)
        }
    }
    
    /*
    * Function: save image to local storage and return the file name
    * @param:
    * @return:
    */
    func saveImage(image: UIImage, completion: @escaping (Error?, String?) -> ()) {
        let fileName = Constants.kdefaultImageName
        let fileURL = documentsUrl.appendingPathComponent(fileName)
        if let imageData = image.jpegData(compressionQuality: 1.0) {
           try? imageData.write(to: fileURL, options: .atomic)
            completion(nil,fileName)
        }else{
            completion( NetworkError.unKnown("Can not save the image file"), nil)
        }
        
    }
    
}
