//
//  bannerCell.swift
//  Resort Real Estate
//
//  Created by Farido on 7/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class bannerCell: UICollectionViewCell {
    
    @IBOutlet weak var images: UIImageView!
    
    func configuerCell(prodect: getAllUnitImages) {
        
        let s = ("\(URLs.mainImage)\(prodect.fileName)")
        let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        
        images.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            print("g\(url)")
            images.kf.setImage(with: url)
        }
        
    }
}
