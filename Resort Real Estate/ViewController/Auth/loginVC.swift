//
//  loginVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/24/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class loginVC: UIViewController {

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var spiner: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
        spiner.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func imageText() {
        
        if let myImage = UIImage(named: "ic_password"){
            
            emailTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "ic_user"){
            
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
    @IBAction func siginBTN(_ sender: Any) {
        guard let userNames = emailTF.text, !userNames.isEmpty else {
            let messages = NSLocalizedString("enter your Full User Name", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = password.text, !passwords.isEmpty else {
            let messages = NSLocalizedString("enter your password", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        self.spiner.startAnimating()
        self.spiner.isHidden = false
        API_Auth.Login(email: emailTF.text ?? "", password: password.text ?? ""){ (error: Error?, success: Bool, data) in
            if success {
                if data == nil {
                    print("success")
                    self.dismiss(animated: true, completion: nil)
                }else {
                    self.showAlert(title: "Register Filed", message: "\(data ?? "") Sorry Try again")
                }
                //
            }else {
                self.showAlert(title: "Register Filed", message: "\(data ?? "") no network")
            }
            self.spiner.stopAnimating()
            self.spiner.isHidden = true
        }
       
    }
    
    
    @IBAction func cancelBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
