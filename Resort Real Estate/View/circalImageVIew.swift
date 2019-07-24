//
//  circalImageVIew.swift
//  Resort Real Estate
//
//  Created by Farido on 7/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

extension UIImageView {
    func setRounded() {
        self.layer.cornerRadius = (self.frame.width / 2) //instead of let radius = CGRectGetWidth(self.frame) / 2
        self.layer.masksToBounds = true
    }
}

