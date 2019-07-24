//
//  getAllUnitattrbutesCell.swift
//  Resort Real Estate
//
//  Created by Farido on 7/18/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class getAllUnitattrbutesCell: UITableViewCell {

    @IBOutlet weak var labelname: UILabel!
    @IBOutlet weak var inputvalue: UILabel!
    
    func configuerCell(prodect: getAllUnitattributes) {
        labelname.text = prodect.labelname
        inputvalue.text = "\(prodect.inputvalue) \(prodect.measruingunittext)"
    }
}
