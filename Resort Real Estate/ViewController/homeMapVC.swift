//
//  ViewController.swift
//  Resort Real Estate
//
//  Created by Farido on 7/9/19.
//  Copyright © 2019 Farido. All rights reserved.
//

import UIKit
import MapKit


protocol HandleMapSearch: class {
    func dropPinZoomIn(_ placemark:MKPlacemark)
}

class customPins: NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    var subtitle: String?
    var id: String?
    
    init(coordinate: CLLocationCoordinate2D, title: String?, subtitle: String,id: String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.id = id
        
        super.init()
    }
    
    var region: MKCoordinateRegion {
        let span = MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04)
        return MKCoordinateRegion(center: coordinate, span: span)
    }
}

class homeMapVC: UIViewController {
    
    var selectedPin: MKPlacemark?
    var resultSearchController: UISearchController!
    
    var GetAllUnitType = [GetAllUnitTypes]()
    var unitTyipString = 0
    let locationManager = CLLocationManager()
    @IBOutlet weak var mapS: MKMapView!
    @IBOutlet weak var typeResidantUnitTF: uitextFiledView!
    
    var annotation = MKPointAnnotation()
    var menuDatas = [menuData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //mapS.delegate = self
        textEnabeld()
        mapS.delegate = self
        setUpNave()
        imageText()
        handleRefresh()
        createTypePiker()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
        let locationSearchTable = storyboard!.instantiateViewController(withIdentifier: "LocationSearchTable") as! LocationSearchTable
        resultSearchController = UISearchController(searchResultsController: locationSearchTable)
        resultSearchController.searchResultsUpdater = locationSearchTable
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search for places"
        navigationItem.titleView = resultSearchController?.searchBar
        resultSearchController.hidesNavigationBarDuringPresentation = false
        resultSearchController.dimsBackgroundDuringPresentation = true
        definesPresentationContext = true
        locationSearchTable.mapView = mapS
        locationSearchTable.handleMapSearchDelegate = self
        
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
    
    
    @IBAction func menuBtn(_ sender: Any) {
        
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
    
    func houseinMap() {
        for meue in menuDatas{
        mapS.register(MKMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        
            let mitCoordinate = CLLocationCoordinate2D(latitude: Double(meue.locationLatit ) ?? 0.0, longitude: Double(meue.locationLatit ) ?? 0.0)
        
            let mitAnnotation = customPins(coordinate: mitCoordinate, title: "House", subtitle: "", id: "1")
        mapS.addAnnotation(mitAnnotation)
        mapS.setRegion(mitAnnotation.region, animated: true)
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setUpNave()
    }
    
    @objc private func handleRefresh() {
        API_Search.advancedSearch(priceto: "", pricefrom: "", noofroom: "", purposetype: "", areasize: "", lat: "", lng: "", lang: "lang",page: 1, unittypeid: "\(unitTyipString)") { (error: Error?, menuDatas: [menuData]?) in
            if let menuDatas = menuDatas {
                self.menuDatas = menuDatas
                print("xxx\(self.menuDatas)")
                self.houseinMap()
            }
        }
        
    }
    
    
    @objc func getDirections(){
        guard let selectedPin = selectedPin else { return }
        let mapItem = MKMapItem(placemark: selectedPin)
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        mapItem.openInMaps(launchOptions: launchOptions)
    }
    
    
    
    func imageText() {
          if let myImage = UIImage(named: "ic_appartment"){
            
            typeResidantUnitTF.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
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
    
    
}

extension homeMapVC: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        guard !(annotation is MKUserLocation) else { return nil }
        
        let reuseId = "pin"
        guard let pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView else { return nil }
        
        pinView.pinTintColor = UIColor.orange
        pinView.canShowCallout = true
        let smallSquare = CGSize(width: 30, height: 30)
        var button: UIButton?
        button = UIButton(frame: CGRect(origin: CGPoint.zero, size: smallSquare))
        button?.setBackgroundImage(UIImage(named: "car"), for: UIControl.State())
        button?.addTarget(self, action: #selector(homeMapVC.getDirections), for: .touchUpInside)
        pinView.leftCalloutAccessoryView = button
        if let vendoAnnoutationView    = mapS.dequeueReusableAnnotationView(withIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier) as? MKMarkerAnnotationView {
            vendoAnnoutationView.animatesWhenAdded = true
            vendoAnnoutationView.titleVisibility = .adaptive
            vendoAnnoutationView.titleVisibility = .adaptive
            
            return vendoAnnoutationView
        }
        return pinView
    }
}

extension homeMapVC : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.first else { return }
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: location.coordinate, span: span)
        mapS.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("error:: \(error)")
    }
    
}

extension homeMapVC: HandleMapSearch {
    
    func dropPinZoomIn(_ placemark: MKPlacemark){
        
        selectedPin = placemark
        mapS.removeAnnotations(mapS.annotations)
        houseinMap()
        let annotation = MKPointAnnotation()
        annotation.coordinate = placemark.coordinate
        annotation.title = placemark.name
        
        if let city = placemark.locality,
            let state = placemark.administrativeArea {
            annotation.subtitle = "\(city) \(state)"
        }
        
        mapS.addAnnotation(annotation)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: placemark.coordinate, span: span)
        mapS.setRegion(region, animated: true)
    }
    
}
extension homeMapVC: UIPickerViewDelegate, UIPickerViewDataSource {
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
        handleRefresh()
        self.view.endEditing(false)
    }
}

