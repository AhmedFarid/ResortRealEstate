//
//  menuDetialsVC.swift
//  Resort Real Estate
//
//  Created by Farido on 7/16/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MapKit

class customPin: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}


class menuDetialsVC: UIViewController {
    
    
    
    @IBOutlet weak var collextionView: UICollectionView!
    @IBOutlet weak var titleTF: UILabel!
    @IBOutlet weak var priceTF: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var sizeTF: UILabel!
    @IBOutlet weak var bedroomTF: UILabel!
    @IBOutlet weak var floor: UILabel!
    @IBOutlet weak var mapVC: MKMapView!
    @IBOutlet weak var tableView: uiTableViewViews!
    @IBOutlet weak var tableViewSmiller: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var iamge: UIImageView!
    @IBOutlet weak var nameTF: UILabel!
    @IBOutlet weak var phoneTF: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var monyView: uiViewsView!
    @IBOutlet weak var numOfShareRemaing: UILabel!
    @IBOutlet weak var numOfSoldShare: UILabel!
    @IBOutlet weak var ShareArea: UILabel!
    @IBOutlet weak var desView: uiViewsView!
    
    var annotation = MKPointAnnotation()
    
    var singleItem: menuData?
    var atuteributs = [getAllUnitattributes]()
    var banners = [getAllUnitImages]()
    var menuDatas = [menuData]()
    
    var isLoading: Bool = false
    var current_page = 1
    var last_page = 50
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        houseinMap()
        mapVC.delegate = self
        //tableView.dropShadow()
        mapVC.dropShadow()
        handleRefresh()
        handleRefreshColletionview()
        handleRefreshOfficeDetials()
        tableView.delegate = self
        tableView.dataSource = self
        tableViewSmiller.delegate = self
        tableViewSmiller.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        iamge.setRounded()
        handleRefreshSmiller()
    }
    
    
    @objc private func handleRefreshSmiller() {
        guard !isLoading else { return }
        isLoading = true
        API_Mune.smillerUnits(unittypeid: "\(singleItem?.unittypeid ?? 0)") { (error: Error?, menuDatas: [menuData]?) in
            self.isLoading = false
            if let menuDatas = menuDatas {
                self.menuDatas = menuDatas
                print("xxx\(self.menuDatas)")
                self.tableViewSmiller.reloadData()
                //self.last_page = last_page
            }
        }
        
    }
    @IBAction func orderBTN(_ sender: Any) {
        if helper.getAPIToken() != nil{
            performSegue(withIdentifier: "suge", sender: singleItem)
        }else {
//            let viewController: UIViewController? = storyboard?.instantiateViewController(withIdentifier: "login")
//            let navi = UINavigationController(rootViewController: viewController!)
//            navigationController?.pushViewController(navi, animated: true)
//            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "login") as? loginVC
//            self.navigationController?.pushViewController(vc!, animated: true)
            
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "login") as! loginVC
            let navigationController = UINavigationController(rootViewController: vc)
            self.present(navigationController, animated: true, completion: nil)


        }
    }
    
//    fileprivate func loadMore() {
//        guard !isLoading else {return}
//        guard current_page < last_page else {return}
//        isLoading = true
//        API_Mune.smillerUnits(unittypeid: "\(singleItem?.unittypeid ?? 0)") { (error: Error?, menuDatas: [menuData]?) in
//            self.isLoading = false
//            if let menuDatas = menuDatas {
//                self.menuDatas.append(contentsOf: menuDatas)
//                print("xxx\(self.menuDatas)")
//                self.tableViewSmiller.reloadData()
//                self.current_page += 1
//                //self.last_page = last_page
//            }
//        }
//    }
//
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destaiantion = segue.destination as? bookRentVC{
            destaiantion.singleItem = singleItem
        }
    }
    
    
    @objc private func handleRefreshOfficeDetials() {
        API_Mune.getOfiiceData(officeid: "\(singleItem?.officeid ?? 0)", completion: { (error, name, phone, iamge) in
            self.nameTF.text = name ?? ""
            self.phoneTF.text = phone ?? ""
            
            let s = ("\(URLs.mainImage)\(iamge ?? "")")
            let encodedLink = s.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
            let encodedURL = NSURL(string: encodedLink!)! as URL
            
            self.iamge.kf.indicatorType = .activity
            if let url = URL(string: "\(encodedURL)") {
                print("g\(url)")
                self.iamge.kf.setImage(with: url)
            }
        })
    }
    
    
    @objc private func handleRefresh() {
        API_Mune.getAllunitattributes(unitid: "\(singleItem?.id ?? 0)") { (error: Error?, atuteributs: [getAllUnitattributes]?) in
            if let atuteributs = atuteributs {
                self.atuteributs = atuteributs
                print("xxx\(self.atuteributs)")
                self.tableView.reloadData()
            }
        }
        
    }
    
    @objc private func handleRefreshColletionview() {
        API_Mune.getAllunitImage(unitid: "\(singleItem?.id ?? 0)"){ (error: Error?, banners: [getAllUnitImages]?) in
            if let banners = banners {
                self.banners = banners
                print("xxx\(self.banners)")
                self.collectionView.reloadData()
            }
        }
        
    }
    
    func houseinMap() {
        mapVC.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
        let mitCoordinate = CLLocationCoordinate2D(latitude: Double(singleItem?.locationLatit ?? "0.0") ?? 0.0, longitude: Double(singleItem?.locationLang ?? "0.0") ?? 0.0)
        
        let mitAnnotation = customPin(coordinate: mitCoordinate, title: "House", subtitle: "")
        mapVC.addAnnotation(mitAnnotation)
        mapVC.setRegion(mitAnnotation.region, animated: true)
        
    }
    
    func setupView(){
        titleTF.text = singleItem?.unitName
        if singleItem?.enablebid == true {
            priceTF.text = "Initial Price\(singleItem?.lastbidprice ?? 0) SAR"
        }else {
            priceTF.text = "\(singleItem?.sellingprice ?? 0) SAR"
        }
        
        if singleItem?.enabledivision == true {
            monyView.isHidden = false
            let x =  (singleItem?.numberOfshare ?? 0)-(singleItem?.countOfSoldShare ?? 0)
            numOfShareRemaing.text = "Number Of Share Remaining: \(x)"
            numOfSoldShare.text = "Number Of Sold Share: \(singleItem?.countOfSoldShare ?? 0)"
            ShareArea.text = "Share area: \(singleItem?.shareAria ?? 0)"
        }else {
            monyView.isHidden = true
        }
        address.text = singleItem?.locationdescription
        time.text = singleItem?.createdat
        des.text = singleItem?.unitdescription
        sizeTF.text = "\(singleItem?.areasize ?? 0)"
        bedroomTF.text = "\(singleItem?.noOfroom ?? 0)"
        floor.text = "\(singleItem?.countoffloors ?? 0)"
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.02352941176, green: 0.568627451, blue: 0.8705882353, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
}


extension menuDetialsVC: MKMapViewDelegate {
    
    // MARK: - MKMapViewDelegate
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let vendoAnnoutationView    = mapVC.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            vendoAnnoutationView.animatesWhenAdded = true
            vendoAnnoutationView.titleVisibility = .adaptive
            vendoAnnoutationView.titleVisibility = .adaptive
            
            return vendoAnnoutationView
        }
        return nil
    }
}

extension UITableView{
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        //
        //        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //        layer.shouldRasterize = true
        //        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}


extension MKMapView{
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowRadius = 1
        //
        //        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        //        layer.shouldRasterize = true
        //        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }
    
}


extension menuDetialsVC: UITableViewDataSource , UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.tag == 0{
            return atuteributs.count
        }else{
            return menuDatas.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 0{
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? getAllUnitattrbutesCell{
                let data = atuteributs[indexPath.row]
                cell.configuerCell(prodect: data)
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return getAllUnitattrbutesCell()
            }
        }else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? menuCell{
                let data = menuDatas[indexPath.row]
                cell.configuerCell(prodect: data)
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return menuCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 0 {
            print("xxxxxx")
        }else {
            singleItem =  menuDatas[indexPath.row]
            setupView()
            houseinMap()
            handleRefresh()
            handleRefreshColletionview()
            handleRefreshOfficeDetials()
            handleRefreshSmiller()
            scrollView.setContentOffset(.zero, animated: true)
        }
    }
}

extension menuDetialsVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return banners.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? bannerCell{
            let data = banners[indexPath.row]
            cell.configuerCell(prodect: data)
            return cell
        }else {
            return bannerCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
