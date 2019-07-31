//
//  normalSellVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class normalSellVC: UIViewController {
    
    var paymentMethod = [getPaymentMethods]()
    var singleItem: menuData?
    var paymentType = 0
    
    @IBOutlet weak var expectedStartDataTF: uitextFiledView!
    @IBOutlet weak var paymentTF: uitextFiledView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTypePiker()
        createDateStart()
    }
    
    
    func getPaymentMethod() {
        API_bookingUnit.getpaymentmethods(unitid: self.singleItem?.id ?? 0) { (error: Error?, paymentMethod: [getPaymentMethods]?) in
            if let paymentMethod = paymentMethod {
                self.paymentMethod = paymentMethod
                print("xxx\(self.paymentMethod)")
                self.textEnabeld()
            }
        }
    }
    
    func createDateStart(){
        var datePiker: UIDatePicker?
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .date
        //datePiker?.calendar = Calendar.init(identifier: Calendar.Identifier.self)
        datePiker?.addTarget(self, action: #selector(normalSellVC.dateChanged(datePiker:)), for: .valueChanged)
        self.view.endEditing(false)
        expectedStartDataTF.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
        let dateFormater = DateFormatter()
        //dateFormater.locale = NSLocale(localeIdentifier: "en_SA") as Locale
        dateFormater.dateFormat = "MM/dd/yyyy"
        expectedStartDataTF.text = dateFormater.string(from: datePiker.date)
        view.endEditing(true)
    }
    
    
    func createTypePiker(){
        let typePiker = UIPickerView()
        typePiker.delegate = self
        typePiker.dataSource = self
        typePiker.tag = 0
        paymentTF.inputView = typePiker
        getPaymentMethod()
        typePiker.reloadAllComponents()
    }
    
    func textEnabeld() {
        if paymentMethod.isEmpty == true {
            paymentTF.isEnabled = false
        }else {
            paymentTF.isEnabled = true
        }
    }
    
    
    @IBAction func bookBTN(_ sender: Any) {
        API_bookingUnit.booksaleunit(unitid: singleItem?.id ?? 0, clientid: "", expectedcontractdate: expectedStartDataTF.text ?? "", paymentmethodtype: paymentType){ (error, data) in
            if data == "200" {
                self.showAlert(title: "Booking success", message: "")
            }else {
                self.showAlert(title: "Booking Fild", message: data ?? "")
            }
        }
        
    }
}


extension normalSellVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return paymentMethod.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return paymentMethod[row].name
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        paymentTF.text = paymentMethod[row].name
        paymentType = paymentMethod[row].id
        self.view.endEditing(false)
    }
}
