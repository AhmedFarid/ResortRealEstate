//
//  bookSharingVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class bookSharingVC: UIViewController {

    var singleItem: menuData?
    
    @IBOutlet weak var newPriceTF: uitextFiledView!
    @IBOutlet weak var numberOfShere: uitextFiledView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    @IBAction func bookBTN(_ sender: Any) {
        API_bookingUnit.addUnitClientPrice(unitid: "\(singleItem?.id ?? 0)", clientid: "", newprice: newPriceTF.text ?? "", countofshare: numberOfShere.text ?? "") { (error, data) in
            if data == "200" {
                if data == "200" {
                    self.showAlert(title: "Booking success", message: "")
                }else {
                    self.showAlert(title: "Booking Fild", message: data ?? "")
                }
            }
            
        }
    }
    
}
