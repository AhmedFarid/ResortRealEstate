//
//  searchVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class searchVC: UIViewController {

    @IBOutlet weak var uinitTypeTF: UITextField!
    @IBOutlet weak var selectLocationTF: UITextField!
    @IBOutlet weak var rentOrCellTF: UITextField!
    @IBOutlet weak var uintSizeTF: UITextField!
    @IBOutlet weak var numberOfRoomsTF: UITextField!
    @IBOutlet weak var priceFrom: UITextField!
    @IBOutlet weak var priceToTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageText()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNave()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func imageText() {
        
        if let myImage = UIImage(named: "Chevron (2)"){
            
            uinitTypeTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Chevron (2)"){
            
            selectLocationTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
        if let myImage = UIImage(named: "Chevron (2)"){
            
            rentOrCellTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Chevron (2)"){
            
            uintSizeTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
        if let myImage = UIImage(named: "Chevron (2)"){
            
            numberOfRoomsTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Group 41"){
            
            priceFrom.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
        if let myImage = UIImage(named: "Group 41"){
            
            priceToTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
    public func setUpNave(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    
    
    @IBAction func searcHBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: nil)
    }
    
}
