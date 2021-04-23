//
//  ViewController.swift
//  airpollution
//
//  Created by leadon-dev on 2021/04/21.
//

import UIKit
import CoreLocation
import SwiftyJSON


class ViewController: UIViewController, CLLocationManagerDelegate, FavoriteDelegate {

    var locationData: [String:Any]!
    var locationManager:CLLocationManager!
    
    var lat : Double!
    var lng : Double!
    
    
    //-- outlet
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var ivStatus: UIImageView!
    @IBOutlet weak var lblDesc: UILabel!
    @IBOutlet weak var lblDateTime: UILabel!
    @IBOutlet weak var lblCityName: UILabel!
    @IBOutlet weak var lblAQI: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true;
        self.initLocationManager()
        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = vwMain.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.addSubview(blurEffectView)
    }
    
    //-- Life Cycle
    override func loadView() {
        super.loadView();
        print("vc:loadView");
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true;
        print("vc:viewWillApeear " + String(animated));
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        print("vc:viewWillDisappear " + String(animated));
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("vc:viewDidAppear " + String(animated));
    }
    
    
    //---------------------------
    // segue
    //---------------------------
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.destination is MapViewController) {
            guard let vc = segue.destination as? MapViewController else { return }
            vc.locationData = self.locationData!
        } else {
            guard let vc = segue.destination as? FavoriteViewController else { return }
            vc.delegate = self
        }
    }
    
    
    
    func initLocationManager() {
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled(){
           locationManager.startUpdatingLocation()
        }
        
    }
    
    
    func status() {
        
        let aqi : UInt16 = locationData["aqi"] as! UInt16
        let checkDateTime : String = locationData["checkDateTime"] as! String
        let cityName : String = locationData["addr_kor"] as! String
        var desc : String = ""
        
        if aqi > 300 {
            vwMain.backgroundColor = #colorLiteral(red: 0.1293928623, green: 0.1294226646, blue: 0.1293909252, alpha: 1)
            ivStatus.image = UIImage(named: "06")
            desc = "나가면 되질듯"
            
        } else if aqi >= 0 && aqi <= 50 {
            vwMain.backgroundColor = #colorLiteral(red: 0, green: 0.4602751136, blue: 0.7551304698, alpha: 1)
            ivStatus.image = UIImage(named: "01")
            desc = "나가서 쳐놀기!!"
            
        } else if aqi >= 51 && aqi <= 100 {
            vwMain.backgroundColor = #colorLiteral(red: 0.2207710445, green: 0.5576006174, blue: 0.2348125279, alpha: 1)
            ivStatus.image = UIImage(named: "02")
            desc = "그냥저냥...보통"
            
        } else if aqi >= 101 && aqi <= 150 {
            vwMain.backgroundColor = #colorLiteral(red: 0.8481995463, green: 0.2626891136, blue: 0.08515860885, alpha: 1)
            ivStatus.image = UIImage(named: "03")
            desc = "얘들은 나가지마"
            
        } else if aqi >= 151 && aqi <= 200 {
            vwMain.backgroundColor = #colorLiteral(red: 0.8481995463, green: 0.2626891136, blue: 0.08515860885, alpha: 1)
            ivStatus.image = UIImage(named: "04")
            desc = "나뻐 가지마"
        } else {
            vwMain.backgroundColor = #colorLiteral(red: 0.8481995463, green: 0.2626891136, blue: 0.08515860885, alpha: 1)
            ivStatus.image = UIImage(named: "05")
            desc = "개 나뻐"
        }
        
        lblAQI.text = "AQI \(aqi)"
        lblDateTime.text = checkDateTime
        lblCityName.text = cityName
        lblDesc.text = desc
        
        
    }
    
    
    func convertToAddressWith(lat: Double, lng:Double)  {
        
        let coord = CLLocation(latitude: lat, longitude: lng)
        let locale = Locale(identifier: "Ko-kr")
        let geoCoder = CLGeocoder()
        var addr : String = ""
        
        
        geoCoder.reverseGeocodeLocation(coord, preferredLocale: locale, completionHandler: {(placemarks, error) in
            
            if error != nil {
                return
            }
            
            let placeMark: CLPlacemark? = placemarks?[0]
            
            if let adminArea = placeMark?.administrativeArea {
                print(adminArea)
            }
            
            if let locality = placeMark?.locality {
                addr.append(locality)
                //print(locality)
            }
            
            if let subLocality = placeMark?.subLocality {
                addr.append(" " + subLocality)
            }
            
            self.locationData["addr_kor"] = addr
            self.status(); // await/async 나 callback 으로..
            
        })
        
    }
    
    
    //---------------------
    //-- delegate
    //---------------------
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            lat = location.coordinate.latitude
            lng = location.coordinate.longitude
            locationData = AirPollutionHelper.sharedInstance.getPollutionInfo(lat: lat, lng: lng)
            convertToAddressWith(lat:lat, lng:lng)
        }
    }
    
    //---------------------
    //-- delegate
    //---------------------
    func dateReceived(data:[String:Any]) {
        let lat : Double = data["lat"] as! Double
        let lng : Double = data["lng"] as! Double
        locationData = AirPollutionHelper.sharedInstance.getPollutionInfo(lat: lat, lng: lng)
        convertToAddressWith(lat:lat, lng:lng)
    }
    

}
