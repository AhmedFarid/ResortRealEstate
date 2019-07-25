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
}
