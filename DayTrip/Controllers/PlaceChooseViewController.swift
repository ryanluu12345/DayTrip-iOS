//
//  PlaceChooseViewController.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/27/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit
import AlamofireImage
import Firebase
import GoogleSignIn

class PlaceChooseViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var itineraryNameTextField: UITextField!
    
    let sectionHeaderHeight: CGFloat = 50
    var places: [String: Any] = [:]
    var selectedPlaces: [String: Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return places.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return sectionHeaderHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: sectionHeaderHeight))
        view.backgroundColor = UIColor(red: 29.0/255.0, green: 161.0/255.0, blue: 242.0/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: sectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        switch (section) {
            case 0:
                label.text = "breakfast"
            case 1:
                label.text = "lunch"
            case 2:
                label.text = "dinner"
            default:
                label.text = "yo"
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sectionCount = places["breakfast"] as? NSArray else {
            return 0
        }
        return sectionCount.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell") as! PlaceTableViewCell
        switch (indexPath.section) {
            case 0:
                let placeArray = places["breakfast"] as! NSArray
                let item = placeArray[indexPath.row] as! [String: Any]
                cell.placeNameLabel.text = item["name"] as! String
                cell.placeImageView.af_setImage(withURL: URL(string: item["image_url"] as! String)!)
            case 1:
                let placeArray = places["lunch"] as! NSArray
                let item = placeArray[indexPath.row] as! [String: Any]
                cell.placeNameLabel.text = item["name"] as! String
                cell.placeImageView.af_setImage(withURL: URL(string: item["image_url"] as! String)!)
            case 2:
                let placeArray = places["dinner"] as! NSArray
                let item = placeArray[indexPath.row] as! [String: Any]
                cell.placeNameLabel.text = item["name"] as! String
                cell.placeImageView.af_setImage(withURL: URL(string: item["image_url"] as! String)!)
            default:
                return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell!.contentView.backgroundColor = UIColor.green
        switch(indexPath.section) {
            case 0:
                let placeArray = places["breakfast"] as! NSArray
                selectedPlaces["breakfast"] = placeArray[indexPath.row]
            case 1:
                let placeArray = places["lunch"] as! NSArray
                selectedPlaces["lunch"] = placeArray[indexPath.row]
            case 2:
                let placeArray = places["dinner"] as! NSArray
                selectedPlaces["dinner"] = placeArray[indexPath.row]
            default:
                return
        }
    }
    
    @IBAction func onLogoutTap(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            UserDefaults.standard.set(nil, forKey: "authToken")
            dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    @IBAction func onItineraryTap(_ sender: Any) {
        let itineraryName = itineraryNameTextField.text ?? ""
        PlacesAPICaller().createItinerary(choices: selectedPlaces, itineraryName: itineraryName) {
            data in
            self.performSegue(withIdentifier: "listItineraries", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapSegue" {
            let placesMapVC = segue.destination as! PlacesMapViewController
            placesMapVC.places = places
        }
    }
}
