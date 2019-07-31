//
//  resevationsVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/29/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit

class resevationsVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var statesSwitch: UISegmentedControl!
    
    var contractsBYCustomers = [GetContractsBYCustomers]()
    
    var unitTyipString = 0
    lazy var refresher: UIRefreshControl = {
        let refresher = UIRefreshControl()
        refresher.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        return refresher
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.addSubview(refresher)
        
        handleRefresh(type: "1")
        
    }
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 50
    
    @objc private func handleRefresh(type: String) {
        self.refresher.endRefreshing()
        guard !isLoading else { return }
        isLoading = true
        API_countecter.getpaymentmethods(page: 1, customerid: "", bookingtype: type) { (error: Error?, contractsBYCustomers: [GetContractsBYCustomers]?) in
            self.isLoading = false
            if let contractsBYCustomers = contractsBYCustomers {
                self.contractsBYCustomers = contractsBYCustomers
                print("xxx\(self.contractsBYCustomers)")
                self.tableView.reloadData()
                self.current_page = 1
                //self.last_page = last_page
            }
        }
        
    }
    
    //    fileprivate func loadMore() {
    //        guard !isLoading else {return}
    //        guard current_page < last_page else {return}
    //        isLoading = true
    //        API_countecter.getpaymentmethods(page: current_page + 1, customerid: "", bookingtype: "1") { (error: Error?, contractsBYCustomers: [GetContractsBYCustomers]?) in
    //            self.isLoading = false
    //            if let contractsBYCustomers = contractsBYCustomers {
    //                self.contractsBYCustomers = contractsBYCustomers
    //                print("xxx\(self.contractsBYCustomers)")
    //                self.tableView.reloadData()
    //                self.current_page += 1
    //                //self.last_page = last_page
    //            }
    //        }
    //    }
    
    @IBAction func `switch`(_ sender: Any) {
        switch statesSwitch.selectedSegmentIndex {
        case 0:
            handleRefresh(type: "1")
        case 1:
            handleRefresh(type: "2")
            
        default:
            break;
        }
    }
}

extension resevationsVC: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contractsBYCustomers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? reservationCell {
            let data = contractsBYCustomers[indexPath.row]
            cell.configuerCell(prodect: data)
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return reservationCell()
        }
        
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        let count = self.contractsBYCustomers.count
    //        if indexPath.row ==  count-1 {
    //            self.loadMore()
    //        }
    //    }
}

