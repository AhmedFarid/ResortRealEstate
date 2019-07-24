//
//  API+Search.swift
//  Resort Real Estate
//
//  Created by Farido on 7/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class API_Search: NSObject {

    class func advancedSearch(priceto: String,pricefrom:String,noofroom: String,purposetype: String,areasize:String,lat:String,lng: String,lang:String,page: Int = 1,unittypeid: String, completion: @escaping (_ error: Error?,_ sparParts: [menuData]?)-> Void) {
        let url = URLs.GetAllUnitsByFilterParameters
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "page": page,
            "unittypeid": unittypeid,
            "lang": lang,
            "lat": lat,
            "lng": lng,
            "priceto": priceto,
            "pricefrom": pricefrom,
            "noofroom": noofroom,
            "purposetype": purposetype,
            "areasize": areasize
            
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
    
    
    class func menuListData(url: String,page: Int = 1, completion: @escaping (_ error: Error?,_ sparParts: [menuData]?)-> Void) {
        let lang = NSLocalizedString("en", comment: "profuct list lang")
        let parameters: [String: Any] = [
            "lang": lang,
            "page": page
        ]
        
        print(parameters)
        Alamofire.request("\(URLs.main)\(url)", method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil) .responseJSON  { response in
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
    
}


