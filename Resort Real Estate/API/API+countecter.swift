//
//  API+countecter.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON



class API_countecter: NSObject {
    class func getpaymentmethods(page: Int = 1,customerid:String,bookingtype: String, completion: @escaping (_ error: Error?,_ sparParts: [GetContractsBYCustomers]?)-> Void) {
        
        let url = URLs.GetBookingsBYCustomer
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        let parameters: [String: Any] = [
            "lang": lang,
            "page": page,
            "customerid": user_token,
            "bookingtype": bookingtype
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            print(url)
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [GetContractsBYCustomers]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = GetContractsBYCustomers.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    class func GetContractsBYCustom(page: Int = 1,customerid:String,bookingtype: String, completion: @escaping (_ error: Error?,_ sparParts: [GetContractsBYCustomer]?)-> Void) {
        
        let url = URLs.GetContractsBYCustomer
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        let parameters: [String: Any] = [
            "lang": lang,
            "page": page,
            "customerid": user_token,
            "contracttype": bookingtype
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            print(url)
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [GetContractsBYCustomer]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = GetContractsBYCustomer.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
}
