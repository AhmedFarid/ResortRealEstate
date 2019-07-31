//
//  API+bookingUnit.swift
//  Resort Real Estate
//
//  Created by Farido on 7/25/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class API_bookingUnit: NSObject {
    class func bookRentUnit(unitid: String,expectedstartdate: String,renttime: String,rettimetype: String ,completion: @escaping (_ error: Error?,_ data: String?) -> Void) {
        
        let url = URLs.bookrentunit
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        let parameters = [
            "unitid": unitid,
            "clientid": user_token,
            "expectedstartdate": expectedstartdate,
            "renttime": renttime,
            "rettimetype": rettimetype
            
            
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let data = json["code"].string {
                    completion(nil, data)
                }
            }
        }
    }
    
    class func booksaleunit(unitid: Int,clientid: String,expectedcontractdate: String,paymentmethodtype: Int ,completion: @escaping (_ error: Error?,_ data: String?) -> Void) {
        
        let url = URLs.booksaleunit
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        let parameters = [
            "unitid": unitid,
            "clientid": user_token,
            "expectedcontractdate": expectedcontractdate,
            "paymentmethodtype": paymentmethodtype,
            ] as [String : Any]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let data = json["code"].string {
                    completion(nil, data)
                }
            }
        }
    }
    
    class func GetUnitPrices(unitid: Int,completion: @escaping (_ error: Error?,_ data: Int?) -> Void) {
        
        let url = URLs.GetUnitPrices
       
        let parameters = [
            "unitid": unitid
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let data = json["data"]["maxprice"].int {
                    completion(nil, data)
                }
            }
        }
    }
    
    class func addUnitClientPrice(unitid: String,clientid: String,newprice: String,countofshare: String ,completion: @escaping (_ error: Error?,_ data: String?) -> Void) {
        
        let url = URLs.AddUnitClientPrice
        guard let user_token = helper.getAPIToken() else {
            completion(nil,nil)
            return
        }
        let parameters = [
            "unitid": unitid,
            "clientid": user_token,
            "newprice": newprice,
            "countofshare": countofshare
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let data = json["code"].string {
                    completion(nil, data)
                }
            }
        }
    }
    
    class func getpaymentmethods(unitid: Int, completion: @escaping (_ error: Error?,_ sparParts: [getPaymentMethods]?)-> Void) {
        
        let url = URLs.GetPaymentMethodTypesByUnitID
        
        let parameters: [String: Any] = [
            "unitid": unitid
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
                var products = [getPaymentMethods]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = getPaymentMethods.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
}
