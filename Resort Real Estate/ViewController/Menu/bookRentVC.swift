//
//  bookRentVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/25/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class bookRentVC: UIViewController {

    
    @IBOutlet weak var exbectedDateTF: uitextFiledView!
    @IBOutlet weak var rentTimeTF: uitextFiledView!
    @IBOutlet weak var rentTypeTF: uitextFiledView!
    
    var singleItem: menuData?
    var rettimetype = ["Month","Year"]
    var type = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDateStart()
        createTypePiker()
        
    }
    
    func createTypePiker(){
        let typePiker = UIPickerView()
        typePiker.delegate = self
        typePiker.dataSource = self
        typePiker.tag = 0
        rentTypeTF.inputView = typePiker
        typePiker.reloadAllComponents()
    }
    
    
    func createDateStart(){
        var datePiker: UIDatePicker?
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .date
        //datePiker?.calendar = Calendar.init(identifier: Calendar.Identifier.self)
        datePiker?.addTarget(self, action: #selector(bookRentVC.dateChanged(datePiker:)), for: .valueChanged)
        self.view.endEditing(false)
        exbectedDateTF.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
        let dateFormater = DateFormatter()
        //dateFormater.locale = NSLocale(localeIdentifier: "en_SA") as Locale
        dateFormater.dateFormat = "MM/dd/yyyy"
        exbectedDateTF.text = dateFormater.string(from: datePiker.date)
        view.endEditing(true)
    }
    
    
    @IBAction func booKBTN(_ sender: Any) {
        bookBtn()
    }
    
    
    func bookBtn() {
        API_bookingUnit.bookRentUnit(unitid: "\(singleItem?.id ?? 0)", expectedstartdate: exbectedDateTF.text ?? "", renttime: rentTimeTF.text ?? "", rettimetype: type) { (error, data) in
            if data == "200" {
                self.showAlert(title: "Booking success", message: "")
            }else {
                self.showAlert(title: "Booking Fild", message: data ?? "")
            }
        }
    }
    
}


extension bookRentVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return rettimetype.count
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        rentTypeTF.text = rettimetype[row]
        if rettimetype[row] == "Month" {
            self.type = "1"
        }else {
            self.type = "2"
        }
        self.view.endEditing(false)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return rettimetype[row]
    }
            
}
