//
//  menuCell.swift
//  Resort Real Estate
//
//  Created by Farido on 7/14/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import Kingfisher

class menuCell: UITableViewCell {

    @IBOutlet weak var images: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var size: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var type: UILabel!
    
    
    func configuerCell(prodect: menuData) {
        title.text = prodect.unitName
        price.text = "\(prodect.sellingprice) SAR"
        size.text = "\(prodect.areasize)"
        time.text = "\(prodect.createdat)"
        address.text = "\(prodect.locationdescription)"
        
        if prodect.purposetype == 1 {
            self.type.text = "For Rent"
        }else {
            self.type.text = "For Sell"
        }
        
        
        let s = ("\(URLs.mainImage)\(prodect.defaultimg)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        images.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            images.kf.setImage(with: url)
        }
        
    }
}
