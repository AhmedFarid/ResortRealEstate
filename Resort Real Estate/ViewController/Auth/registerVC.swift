//
//  registerVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/24/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class registerVC: UIViewController {

    @IBOutlet weak var fullNameTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var idTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    @IBAction func signUpBTN(_ sender: Any) {
        
        guard let names = fullNameTF.text, !names.isEmpty else {
            let messages = NSLocalizedString("enter your Full name", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let userNames = userNameTF.text, !userNames.isEmpty else {
            let messages = NSLocalizedString("enter your Full User Name", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let phones = phoneTF.text, !phones.isEmpty else {
            let messages = NSLocalizedString("enter your phone", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let emails = emailTF.text, !emails.isEmpty else {
            let messages = NSLocalizedString("enter your Email", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let passwords = passwordTF.text, !passwords.isEmpty else {
            let messages = NSLocalizedString("enter your password", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard isValidEmail(testStr: emails) == true else {
            let messages = NSLocalizedString("email not correct", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let addresss = idTF.text, !addresss.isEmpty else {
            let messages = NSLocalizedString("enter your Id", comment: "hhhh")
            let title = NSLocalizedString("Register Filed", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }

        getRegistet()
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    
    
    func getRegistet(){
        
        API_Auth.register(client_id: idTF.text ?? "", phone: phoneTF.text ?? "", id: idTF.text ?? "", email: emailTF.text ?? "", username: userNameTF.text ?? "", name: fullNameTF.text ?? "", password: passwordTF.text ?? ""){ (error: Error?, success: Bool, data) in
            if success {
                if data == nil {
                    print("success")
//                    guard let window = UIApplication.shared.keyWindow else {return}
//
//                            var vc: UIViewController
//                            if helper.getAPIToken() == nil {
//                                let sb = UIStoryboard(name: "Main", bundle: nil)
//                                vc = sb.instantiateInitialViewController()!
//                            }else {
//                                let sb = UIStoryboard(name: "Main", bundle: nil)
//                                vc = sb.instantiateViewController(withIdentifier: "main")
//                            }
//                            window.rootViewController = vc
//                            UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
                    self.dismiss(animated: true, completion: nil)
                }else {
                    self.showAlert(title: "Register Filed", message: "\(data ?? "") Sorry Try again")
                }
                //
            }else {
                self.showAlert(title: "Register Filed", message: "\(data ?? "") Sorry Try again")
            }
            
        }
    }
    
}
