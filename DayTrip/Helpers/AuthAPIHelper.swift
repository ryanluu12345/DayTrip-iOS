//
//  PlacesAPIHelper.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/27/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import Foundation
import Alamofire

class AuthAPICaller {
    
    let baseURL:String = "https://16beb6ec.ngrok.io"
    
    func loginAndAuth(token: String, completion: @escaping ([String: Any]) -> ()) {
        let parameters = ["token": token]
        
        Alamofire.request("\(baseURL)/auth", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .responseJSON { response in
                switch(response.result) {
                    case .success:
                        completion(["success":true])
                    case .failure(let err):
                        print(err.localizedDescription)
                        print(response.response?.statusCode)
                }
        }
    }
    
}
