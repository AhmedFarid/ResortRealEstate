//
//  ViewController.swift
//  Resort Real Estate
//
//  Created by Farido on 7/9/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class homeMapVC: UIViewController {

    
    
    @IBOutlet weak var locationTF: uitextFiledView!
    @IBOutlet weak var typeResidantUnitTF: uitextFiledView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNave()
        imageText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNave()
    }
    
    
    func imageText() {
        
        if let myImage = UIImage(named: "ic_location"){
            
            locationTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "ic_appartment"){
            
            typeResidantUnitTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
    public func setUpNave(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }


}

