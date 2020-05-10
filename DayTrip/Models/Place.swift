//
//  Place.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/28/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import Foundation
import MapKit

class Place: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let locationUrl: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, locationUrl: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.locationUrl = locationUrl
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}
