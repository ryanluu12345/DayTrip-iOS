//
//  PlacesAPIHelper.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/27/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import Foundation
import Alamofire

class PlacesAPICaller {
    
    let baseURL:String = "https://16beb6ec.ngrok.io"
    
    func getPlaces(location: String, price: String, startTime: String, endTime: String, completion: @escaping ([String: Any]) -> ()) {
        let parameters: [String:Any] = [
            "location": location,
            "price": price,
            "startTime": startTime,
            "endTime": endTime
        ]
        
        Alamofire.request("\(baseURL)/suggestions", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch(response.result) {
                case .success(let jsonData):
                    completion(jsonData as! [String:Any])
                case .failure(let err):
                    print(err.localizedDescription)
                    print(response.response?.statusCode)
                }
        }
    }
    
    func createItinerary(choices: [String:Any], itineraryName: String, completion: @escaping ([String: Any]) -> ()) {
        let parameters: [String:Any] = ["choices": choices,
                "name": itineraryName]
        var headers = ["Authorization": ""]
        
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            headers["Authorization"] = token
        }
        
        Alamofire.request("\(baseURL)/itinerary", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch(response.result) {
                case .success(let jsonData):
                    completion(jsonData as! [String:Any])
                case .failure(let err):
                    print(err.localizedDescription)
                    print(response.response?.statusCode)
                }
        }
    }
    
    func getItinerariesList(completion: @escaping ([[String: Any]]) -> ()) {
        var headers = ["Authorization": ""]
        
        if let token = UserDefaults.standard.string(forKey: "authToken") {
            headers["Authorization"] = token
        }
        
        Alamofire.request("\(baseURL)/itineraryList", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers)
            .responseJSON { response in
                switch(response.result) {
                case .success(let jsonData):
                    completion(jsonData as! [[String:Any]])
                case .failure(let err):
                    print(err.localizedDescription)
                    print(response.response?.statusCode)
                }
        }
    }
}
