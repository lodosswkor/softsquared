//
//  AddrViewController.swift
//  airpollution
//
//  Created by leadon-dev on 2021/04/22.
//

import UIKit
import CoreLocation


protocol FavoriteDelegate {
    func dateReceived(data: [String:Any])
}

class FavoriteViewController: UIViewController {

    
    var locationDataList : Array<[String:Any]>?
    var btnArr:[UIButton]?
    var delegate : FavoriteDelegate?
    
    @IBOutlet weak var btnTemp: UIBarButtonItem!
    @IBOutlet weak var sbAddr: UISearchBar!
    
    @IBOutlet weak var txtSearch: UITextField!
    @IBOutlet weak var btnSearch: UIButton!
    
    @IBOutlet weak var vwContents: UIView!
    
    //-- Life Cycle
    override func loadView() {
        super.loadView();
        print("fc:loadView");
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "즐겨찾기";
        locationDataList = Array<[String:Any]>()
        btnArr = Array<UIButton>()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false;
        print("fc:viewWillApeear " + String(animated));
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("fc:viewWillDisappear " + String(animated));
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("fc:viewDidAppear " + String(animated));
    }
    
    
    ///
    @IBAction func btnSearch_Click(_ sender: Any) {
        guard let searchTxt = txtSearch.text else { return }
        let geoCoder = CLGeocoder()
        let address = "\(searchTxt)"
        geoCoder.geocodeAddressString(address) { (placemarks, error) in
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
    }
    
    @IBAction func btnSelectedData(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //-- 주소 -> 좌표
    private func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        
        if let error = error {
            print("Unable to Forward Geocode Address (\(error))")
        } else {
            var location: CLLocation?
            if let placemarks = placemarks, placemarks.count > 0 {
                location = placemarks.first?.location
            }

            if let location = location {
                let coord = location.coordinate
                //locationDataList?.append(["lat":coord.latitude,"lng":coord.longitude])
                //print(locationDataList?.count)
                
            
                if var locationData = locationDataList {
                    locationData.append(["lat": coord.latitude,"lng":coord.longitude])
                    delegate?.dateReceived(data: locationData[0])
                    dismiss(animated: true, completion: nil)
                }
                
            } else {
                print("No Matching Location Found")
            }
        }
    }
    
}
