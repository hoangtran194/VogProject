//
//  UserAccessAPI.swift
//  VogProject
//
//  Created by Hoang Tran on 2020-08-29.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import UIKit
import Alamofire

let header = ["Content-Type":"application/json"]
enum NetworkError : Error
{
    case unKnown(String)
}


class UserAccessAPI: UserAccessProtocol {

    
    static var shared : UserAccessAPI = UserAccessAPI()
    
    ///////////////////////////////////////////////////////////////
    //MARK: - APIs
    ///////////////////////////////////////////////////////////////
    func getUserData(completion : @escaping(Error?,UserModel?)->()){
        
        let endPoint        = Constants.getProfile
        let header          = headerWithToken()
        
        AF.request(endPoint,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(header))
            .responseString { (response) in
                
                if let error = response.error{
                    
                    completion(error,nil)
                    return
                    
                }
                do{
                    
                    let result = try JSONDecoder().decode(UserModel.self, from: response.data!)
                    completion(nil,result)
                    
                }catch{
                    
                    //Need to refine the error handling here to get exact error message
                    print(error)
                    completion( NetworkError.unKnown(response.value ?? ""), nil)
                }
        }
    }
    
    
    func setUserData(_ userData : UserModel ,completion : @escaping(Error?,UserModel?)->()) {
        let endPoint        = Constants.updateProfile
        let header          = headerWithToken()
        let parameters      = userData.toDictionary()
        
        AF.request(endPoint,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(header))
            .responseString { (response) in
                
                if let error = response.error{
                    
                    completion(error,nil)
                    return
                    
                }
                do{
                    
                    let result = try JSONDecoder().decode(UserModel.self, from: response.data!)
                    completion(nil,result)
                    
                }catch{
                    //Need to refine the error handling here to get exact error message
                    print(error)
                    completion( NetworkError.unKnown(response.value ?? ""), nil)
                }
        }
    }
    
    func setUserPassword(_ newPassword: String, completion: @escaping (Error?, UserModel?) -> ()) {
        let endPoint        = Constants.updatePassWord
        let header          = headerWithToken()
        let parameters      = [Constants.kUserPassWord:newPassword]
        
        AF.request(endPoint,
                   method: .post,
                   parameters: parameters,
                   encoding: JSONEncoding.default,
                   headers: HTTPHeaders(header))
            .responseString { (response) in
                
                if let error = response.error{
                    
                    completion(error,nil)
                    return
                    
                }
                do{
                    
                    let result = try JSONDecoder().decode(UserModel.self, from: response.data!)
                    completion(nil,result)
                    
                }catch{
                    
                    //Need to refine the error handling here to get exact error message
                    print(error)
                    completion( NetworkError.unKnown(response.value ?? ""), nil)
                }
        }
    }
    
    func loadImage(imageURL: String, completion: @escaping (Error?, UIImage?) -> ()) {
        completion( NetworkError.unKnown("Need to implement get image from URL"), nil)
    }
    
    func saveImage(image: UIImage, completion: @escaping (Error?, String?) -> ()) {
        completion( NetworkError.unKnown("Need to implement save image"), nil)
    }
}


extension UserAccessAPI{
    /*
     * Function: Craete the header with Token inside
     * @param:
     * @return:
     */
    fileprivate func headerWithToken()->[String:String]
    {
        var result = ["Content-Type":"application/json"]
        let token =  Constants.kTokenValue
        if token != ""{
            result["Authorization"] = "Bearer " + token
        }
        return result
    }

}
