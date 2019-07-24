//
//  searchResultVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/22/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class searchResultVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menuDatas = [menuData]()
    
//    lazy var refresher: UIRefreshControl = {
//        let refresher = UIRefreshControl()
//        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
//        return refresher
//    }()
    
    var page = ""
    var unittypeid = 0
    var lat = "null"
    var lng = "null"
    var priceto = ""
    var pricefrom = ""
    var noofroom = "0"
    var purposetype = ""
    var areasize = ""
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        hundelApp()
        //handleRefreshProfile()
        //tableView.addSubview(refresher)
        
    }
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 50
    
    
    func hundelApp(){
    if url == ""{
    handleRefresh()
    }else {
    handleRefreshProfile()
    }
    }
    
    func hundelAppLodmore(){
        if url == ""{
            if menuDatas.count >= 15{
            loadMore()
            }
        }else {
            if menuDatas.count >= 15 {
            loadMoreProfile()
            }
        }
    }
    
   
    
    @objc private func handleRefreshProfile() {
        //self.refresher.endRefreshing()
        guard !isLoading else { return }
        isLoading = true
        API_Search.menuListData(url: url, page: 1) { (error: Error?, menuDatas: [menuData]?) in
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
    
   
    @objc private func handleRefresh() {
        //self.refresher.endRefreshing()
        guard !isLoading else { return }
        isLoading = true
        API_Search.advancedSearch(priceto: priceto, pricefrom: pricefrom, noofroom: noofroom, purposetype: purposetype, areasize: areasize, lat: lat, lng: lng, lang: "lang",page: 1, unittypeid: "\(unittypeid)") { (error: Error?, menuDatas: [menuData]?) in
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
    
    fileprivate func loadMore() {
        guard !isLoading else {return}
        guard current_page < last_page else {return}
        isLoading = true
        API_Search.advancedSearch(priceto: priceto, pricefrom: pricefrom, noofroom: noofroom, purposetype: purposetype, areasize: areasize, lat: lat, lng: lng, lang: "lang",page: current_page + 1, unittypeid: "\(unittypeid)") { (error: Error?, menuDatas: [menuData]?) in
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
    
    
    fileprivate func loadMoreProfile() {
        guard !isLoading else {return}
        guard current_page < last_page else {return}
        isLoading = true
        API_Search.menuListData(url: url, page: current_page + 1) { (error: Error?, menuDatas: [menuData]?) in
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
    
}

extension searchResultVC: UITableViewDelegate,UITableViewDataSource {
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
            self.hundelAppLodmore()
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? menuDetialsVC{
            destaiantion.singleItem = sender as! menuData
        }
    }
    
}
