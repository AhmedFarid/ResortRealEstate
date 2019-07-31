//
//  conterctsCell.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class conterctsCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var topName: UILabel!
    @IBOutlet weak var socendName: UILabel!
    @IBOutlet weak var timeONe: UILabel!
    @IBOutlet weak var time2: UILabel!
    
    
    
    func configuerCell(prodect: GetContractsBYCustomer) {
        
        title.text = prodect.customername
        topName.text = prodect.customername
        socendName.text = prodect.customername
        timeONe.text = prodect.date
        time2.text = "\(prodect.amount)"
        
    }
    

    
    
}
