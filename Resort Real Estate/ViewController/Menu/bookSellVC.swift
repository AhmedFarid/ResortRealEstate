//
//  bookReantVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/25/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class bookSellVC: UIViewController {
    
    @IBOutlet weak var inatialPriceLabl: uiLabeViews!
    @IBOutlet weak var lastPrice: uiLabeViews!
    @IBOutlet weak var addPriceTF: uitextFiledView!
    
    var singleItem: menuData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMaxPrice()
    }
    
    
    func getMaxPrice(){
        
        API_bookingUnit.GetUnitPrices(unitid: singleItem?.id ?? 0) { (error, data) in
            self.lastPrice.text = "\(data ?? 0)"
            self.inatialPriceLabl.text = "\(self.singleItem?.lastbidprice ?? 0)"
        }
    }
    
    
    @IBAction func addBTN(_ sender: Any) {
        
        API_bookingUnit.addUnitClientPrice(unitid: "\(singleItem?.id ?? 0)", clientid: "", newprice: addPriceTF.text ?? "", countofshare: "\(0)") { (error, data) in
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
