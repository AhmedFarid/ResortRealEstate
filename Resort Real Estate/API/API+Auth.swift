//
//  API+Auth.swift
//  Resort Real Estate
//
//  Created by Farido on 7/24/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


class API_Auth: NSObject {
    
    class func register(client_id: String,phone: String,id:String,email:String,username: String,name: String,password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.InsertCustomer
        print(url)
        let parameters = [
            "name": name,
            "password": password,
            "username": username,
            "email": email,
            "usertype": "2",
            "id": id,
            "phone":phone,
            "client_id": "AndroidApp",
            "client_secret": "321456"
            
            
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let user_token = json["data"]["access_token"].string {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token)
                    completion(nil, true , nil)
                }else {
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
    
    class func Login(email:String,password: String, completion: @escaping (_ error: Error?, _ success: Bool, _ data: String?)->Void) {
        
        let url = URLs.login
        print(url)
        let parameters = [
            "password": password,
            "username": email,
            "client_id": "AndroidApp",
            "client_secret": "321456"
            
            
        ]
        
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded"
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: headers) .responseJSON { response in
            switch response.result
            {
            case .failure(let error):
                completion(error, false, nil)
                print(error)
                //self.showAlert(title: "Error", message: "\(error)")
                
            case .success(let value):
                let json = JSON(value)
                print(value)
                if let user_token = json["data"]["access_token"].string {
                    print("user token \(user_token)")
                    helper.saveAPIToken(token: user_token)
                    completion(nil, true , nil)
                }else {
                    let data = json["message"].string
                    print(data ?? "no")
                    completion(nil, true, data)
                }
                
            }
        }
        
    }
    
}
