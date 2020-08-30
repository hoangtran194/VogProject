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
    
    
    ///////////////////////////////////////////////////////////////
    //MARK: - APIs
    ///////////////////////////////////////////////////////////////
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
    
    ///////////////////////////////////////////////////////////////
    //MARK: - APIs
    ///////////////////////////////////////////////////////////////
    func setUserPassword(_ userData : UserModel ,completion : @escaping(Error?,UserModel?)->()) {
        let endPoint        = Constants.updatePassWord
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
        let token = KeychainManager.shareInstance.getString(keyString: Constants.kToken)
        if token != ""{
            result["Authorization"] = "Bearer " + token
        }
        return result
    }

}
