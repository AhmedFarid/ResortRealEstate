//
//  API+Mune.swift
//  Resort Real Estate
//
//  Created by Farido on 7/15/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class API_Mune: NSObject {
    
    class func menuListData(page: Int = 1, completion: @escaping (_ error: Error?,_ sparParts: [menuData]?)-> Void) {
        let url = URLs.getunitsBylang
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "lang": lang,
            "page": page
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [menuData]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = menuData.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    
    class func getAllunitattributes(unitid: String, completion: @escaping (_ error: Error?,_ sparParts: [getAllUnitattributes]?)-> Void) {
        let url = URLs.getAllUnitattributesByUnitIdv2
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "lang": lang,
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [getAllUnitattributes]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = getAllUnitattributes.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    
    
    class func getAllunitImage(unitid: String, completion: @escaping (_ error: Error?,_ sparParts: [getAllUnitImages]?)-> Void) {
        
        let url = URLs.GetAllUnitImages
        let parameters = [
            "unitid": unitid,
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [getAllUnitImages]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = getAllUnitImages.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    
    class func getOfiiceData(officeid: String, completion: @escaping (_ error: Error?,_ name: String?,_ phone: String?,_ image: String?) -> Void) {
        
        let url = URLs.getofficequikdata
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters = [
            "officeid": officeid,
            "lang": lang
        ]
        
        print(parameters)
        Alamofire.request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
            
            switch response.result
            {
            case .failure(let error):
                completion(error, nil,nil,nil)
                print(error)
                
            case .success(let value):
                print(value)
                let json = JSON(value)
                if let name = json["data"]["name"].string {
                    let phone = json["data"]["phone"].string
                    let image = json["data"]["image"].string
                    completion(nil, name,phone,image)
                }
            }
        }
    }
    
    class func smillerUnits(page: Int = 1, unittypeid: String, completion: @escaping (_ error: Error?,_ sparParts: [menuData]?)-> Void) {
        let url = URLs.GetAllUnitsByFilterParameters
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "lang": lang,
            "unittypeid": unittypeid,
            "page": page
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [menuData]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = menuData.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    
    
    class func GetAllUnitType(completion: @escaping (_ error: Error?,_ sparParts: [GetAllUnitTypes]?)-> Void) {
        let url = URLs.GetAllUnitTypes
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "lang": lang
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
                guard let dataArray = json["data"].array else{
                    completion(nil, nil)
                    return
                }
                print(dataArray)
                var products = [GetAllUnitTypes]()
                for data in dataArray {
                    if let data = data.dictionary, let prodect = GetAllUnitTypes.init(dict: data){
                        products.append(prodect)
                    }
                }
                completion(nil,products)
            }
        }
    }
    
}


