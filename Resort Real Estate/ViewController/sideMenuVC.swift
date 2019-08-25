//
//  sideMenuVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MOLH

class sideMenuVC: UIViewController {
    
    @IBOutlet weak var logout: uiBottenView!
    @IBOutlet weak var logoutBTN: uiBottenView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if helper.getAPIToken() != nil{
            
        }else {
            logout.isHidden = true
            logoutBTN.isHidden = true
        }
    }
    
    
    @IBAction func langBTN(_ sender: Any) {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar-EG" : "en")
        MOLH.reset(transition: .transitionCrossDissolve)
    }
    
    
    @IBAction func logoutBTN(_ sender: Any) {
        helper.dleteAPIToken()
    }
}
