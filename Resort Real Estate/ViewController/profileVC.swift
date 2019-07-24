//
//  profileVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/11/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class profileVC: UIViewController {

    @IBOutlet weak var loginBTNOutlat: uiBottenView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if helper.getAPIToken() != nil {
            loginBTNOutlat.isHidden = true
        }
        setUpNave()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    

    public func setUpNave(){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    
    

    @IBAction func specialRealstateBTN(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "getfeaturedunitsBylang")
    }
    
    @IBAction func realStateBit(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "getbidunitsBylang")
    }
    
    @IBAction func neweADs(_ sender: Any) {
        performSegue(withIdentifier: "suge", sender: "getnewestunitsBylang")
    }
    
    
    @IBAction func loginBtn(_ sender: Any) {
        performSegue(withIdentifier: "suge2", sender: "getnewestunitsBylang")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? searchResultVC{
            destaiantion.url = sender as! String
        }
    }
    
    
}
