//
//  MapViewController.swift
//  airpollution
//
//  Created by leadon-dev on 2021/04/22.
//

import UIKit
import WebKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapWebView: WKWebView!
    
    var locationData: [String : Any]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //-- Life Cycle
    override func loadView() {
        super.loadView();
    }
    
    
    
    //-- MapLoading
    override func viewWillAppear(_ animated: Bool) {
        
        navigationController?.isNavigationBarHidden = false;
        
        var str_lat : String = ""
        var str_lng : String = ""
        
        if let data = locationData {
            self.navigationItem.title = data["addr_kor"] as? String
            str_lat = String(data["lat"] as! Double)
            str_lng = String(data["lng"] as! Double)
        }
        
        if let mapUrl = Bundle.main.url(forResource: "map",
                                        withExtension: "html") {
            let urlWithParam = URL(string: "?lat=\(str_lat)&lng=\(str_lng)", relativeTo: mapUrl)!
            self.mapWebView.loadFileURL(urlWithParam,allowingReadAccessTo: urlWithParam)
        }
        print("mc:viewWillApeear " + String(animated));
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("mc:viewWillDisappear " + String(animated));
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("mc:viewDidAppear " + String(animated));
        
    }
    

}


