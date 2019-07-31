//
//  menuVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/9/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class menuVC: UIViewController {
    
    @IBOutlet weak var locationTF: uitextFiledView!
    @IBOutlet weak var typeResidantUnitTF: uitextFiledView!
    @IBOutlet weak var tableView: UITableView!
    
    var menuDatas = [menuData]()
    var GetAllUnitType = [GetAllUnitTypes]()
    var unitTyipString = 0
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //setUpNave()
        imageText()
        
        tableView.delegate = self
        tableView.dataSource = self
        locationTF.delegate = self
        typeResidantUnitTF.delegate = self
        textEnabeld()
        tableView.addSubview(refresher)
        handleRefresh()
        createTypePiker()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNave()
    }
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 50
    
    @objc private func handleRefresh() {
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        isLoading = true
        API_Mune.menuListData(page: 1) { (error: Error?, menuDatas: [menuData]?) in
            self.isLoading = false
            if let menuDatas = menuDatas {
                self.menuDatas = menuDatas
                print("xxx\(self.menuDatas)")
                self.tableView.reloadData()
                self.current_page = 1
                //self.last_page = last_page
            }
        }
        
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
            typeResidantUnitTF.isEnabled = false
        }else {
            typeResidantUnitTF.isEnabled = true
        }
    }
    
    func createTypePiker(){
        let typePiker = UIPickerView()
        typePiker.delegate = self
        typePiker.dataSource = self
        typePiker.tag = 0
        typeResidantUnitTF.inputView = typePiker
        handleRefreshUnitType()
        typePiker.reloadAllComponents()
    }
    
    fileprivate func loadMore() {
        guard !isLoading else {return}
        guard current_page < last_page else {return}
        isLoading = true
        API_Mune.menuListData(page: current_page + 1) { (error: Error?, menuDatas: [menuData]?) in
            self.isLoading = false
            if let menuDatas = menuDatas {
                self.menuDatas.append(contentsOf: menuDatas)
                print("xxx\(self.menuDatas)")
                self.tableView.reloadData()
                self.current_page += 1
                //self.last_page = last_page
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
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
    
    @objc private func handleRefreshSearch() {
        API_Search.advancedSearch(priceto: "", pricefrom: "", noofroom: "", purposetype: "", areasize: "", lat: "", lng: "", lang: typeResidantUnitTF.text ?? "",page: 1, unittypeid: "\(unitTyipString)") { (error: Error?, menuDatas: [menuData]?) in
            self.isLoading = false
            if let menuDatas = menuDatas {
                self.menuDatas = menuDatas
                print("xxx\(self.menuDatas)")
                self.tableView.reloadData()
            }
        }
        
    }
    
}


extension menuVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? menuCell {
            let data = menuDatas[indexPath.row]
            cell.configuerCell(prodect: data)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return menuCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "suge", sender: menuDatas[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let count = self.menuDatas.count
        if indexPath.row ==  count-1 {
            self.loadMore()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? menuDetialsVC{
            destaiantion.singleItem = sender as! menuData
        }
    }
    
}


extension menuVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return GetAllUnitType.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return GetAllUnitType[row].namear
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        typeResidantUnitTF.text = GetAllUnitType[row].namear
        unitTyipString = GetAllUnitType[row].id
        handleRefreshSearch()
        self.view.endEditing(false)
    }
}


extension menuVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        locationTF.resignFirstResponder()
        typeResidantUnitTF.resignFirstResponder()//if desired
        handleRefreshSearch()
        return true
    }
    
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        handleRefresh()
        return true
    }
}
