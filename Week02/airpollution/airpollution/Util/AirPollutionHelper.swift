//
//  AirPollutionHelper.swift
//  airpollution
//
//  Created by lodossw on 2021/04/23.
//

import Foundation
import SwiftyJSON

class AirPollutionHelper:NSObject {
    
    static let sharedInstance = AirPollutionHelper()
    
    var token : String = "7ff740e4bd5074fa7a0f1cfe90cee3bb0b74fffe"
    var apiUrl : String = "https://api.waqi.info"
    
    
    public func getPollutionInfo(lat: Double, lng: Double)-> [String:Any]{
        
        var requestUrl : String = apiUrl + "/feed/geo:{lat};{lng}/?token={token}"
        var rtn : [String:Any] = ["status": "no"]
        
        requestUrl = requestUrl.replacingOccurrences(of: "{lat}", with: String(lat))
                               .replacingOccurrences(of: "{lng}", with: String(lng))
                               .replacingOccurrences(of: "{token}", with: token);
        
        
        do {
            
            let url = URL(string: requestUrl)
            let res = try String(contentsOf: url!)
            let responseData = Data(res.utf8)
            let json = try JSON(data: responseData)
            
            
            if let cityName = json["data"]["city"]["name"].string {
                rtn["cityName"] = cityName
            }
            
            if let aqi = json["data"]["aqi"].uInt16 {
                rtn["aqi"] = aqi
            }
            
            if let lat = json["data"]["city"]["geo"][0].double {
                rtn["lat"] = lat
            }
            
            if let lng = json["data"]["city"]["geo"][1].double {
                rtn["lng"] = lng
            }
            
            if let dateTime = json["data"]["time"]["s"].string {
                rtn["checkDateTime"] = dateTime
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
        return rtn
    }
    
    
}
