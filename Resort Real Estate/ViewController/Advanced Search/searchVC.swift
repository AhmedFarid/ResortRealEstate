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
    
    
    var typeOfSell = ["For Sell","For Rent"]
    var typeOfSellString = ""
    var unitTypeID = 0
    var GetAllUnitType = [GetAllUnitTypes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTypePiker()
        createSellTypePiker()
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
    
    @objc private func handleRefreshUnitType() {
        API_Mune.GetAllUnitType{ (error: Error?, GetAllUnitType: [GetAllUnitTypes]?) in
            if let GetAllUnitType = GetAllUnitType {
                self.GetAllUnitType = GetAllUnitType
                print("xxx\(self.GetAllUnitType)")
                self.textEnabeld()
            }
        }
    }
    
    func textEnabeld() {
        if GetAllUnitType.isEmpty == true {
            uinitTypeTF.isEnabled = false
        }else {
            uinitTypeTF.isEnabled = true
        }
    }
    
    func createTypePiker(){
        let typePiker = UIPickerView()
        typePiker.delegate = self
        typePiker.dataSource = self
        typePiker.tag = 0
        uinitTypeTF.inputView = typePiker
        handleRefreshUnitType()
        typePiker.reloadAllComponents()
    }
    
    func createSellTypePiker(){
        let sellTypePiker = UIPickerView()
        sellTypePiker.delegate = self
        sellTypePiker.dataSource = self
        sellTypePiker.tag = 1
        rentOrCellTF.inputView = sellTypePiker
        sellTypePiker.reloadAllComponents()
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? searchResultVC{
            destaiantion.areasize = uintSizeTF.text ?? ""
            destaiantion.lat = ""
            destaiantion.lng = ""
            destaiantion.noofroom = numberOfRoomsTF.text ?? ""
            destaiantion.pricefrom = priceFrom.text ?? ""
            destaiantion.priceto = priceToTF.text ?? ""
            if typeOfSellString == "For Rent" {
                destaiantion.purposetype = "1"
            }else if typeOfSellString == "For Sell" {
               destaiantion.purposetype = "2"
            }else {
                destaiantion.purposetype = ""
            }
            destaiantion.unittypeid = unitTypeID
            
        }
    }
    
}


extension searchVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.tag == 0 {
            return GetAllUnitType.count
        }else {
            return typeOfSell.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView.tag == 0 {
            return GetAllUnitType[row].namear
        }else {
            return typeOfSell[row]
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView.tag == 0{
            uinitTypeTF.text = GetAllUnitType[row].namear
            unitTypeID = GetAllUnitType[row].id
            self.view.endEditing(false)
        }else {
            rentOrCellTF.text = typeOfSell[row]
            typeOfSellString = typeOfSell[row]
            self.view.endEditing(false)
        }
    }
}
