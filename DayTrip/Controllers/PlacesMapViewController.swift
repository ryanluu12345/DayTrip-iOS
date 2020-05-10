//
//  PlacesMapViewController.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/28/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit
import MapKit

class PlacesMapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    
    var places: [String: Any] = [:]
    var placesCleaned = [Place]()
    let regionRadius: CLLocationDistance = 10000
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapPlaceDictToModel()
        centerMapOnLocation(location: (placesCleaned.first?.coordinate)!)
        mapView.addAnnotations(placesCleaned)
    }
    
    func centerMapOnLocation(location: CLLocationCoordinate2D) {
        let coordinateRegion = MKCoordinateRegion(center: location,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapPlaceDictToModel() {
        for (_, value) in places {
            var valArray = value as! [[String: Any]]
            for place in valArray {
                var placeDict = place
                var name = placeDict["name"] as! String
                var url = placeDict["url"] as! String
                var coordString = placeDict["coordinates"] as! [String: Double]
                var coordinates = CLLocationCoordinate2D(latitude: coordString["latitude"]!, longitude: coordString["longitude"]!)
                var newPlace = Place.init(title: name, locationName: name, locationUrl: url, coordinate: coordinates)
                placesCleaned.append(newPlace)
            }
        }
    }
}
