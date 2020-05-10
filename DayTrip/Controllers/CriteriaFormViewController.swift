//
//  CriteriaFormViewController.swift
//  DayTrip
//
//  Created by Ryan Luu on 4/27/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit
import Alamofire
import Firebase
import GoogleSignIn

class CriteriaFormViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var locationField: UITextField!
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    @IBOutlet weak var pricePicker: UIPickerView!
    
    var priceOptions: [String] = ["$", "$$", "$$$", "$$$$"]
    var places: [String: Any] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pricePicker.delegate = self
        self.pricePicker.dataSource = self
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priceOptions.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priceOptions[row]
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
    
    @IBAction func onSubmitTap(_ sender: Any) {
        let location = locationField.text!
        let priceOption = priceOptions[pricePicker.selectedRow(inComponent: 0)]
        let startTime = extractTime(datePicker: startPicker)
        let endTime = extractTime(datePicker: endPicker)
        
        PlacesAPICaller().getPlaces(location: location, price: priceOption, startTime: startTime, endTime: endTime) {
            data in
            self.places = data
            self.performSegue(withIdentifier: "chooseSegue", sender: nil)
        }
    }
    
    func extractTime(datePicker:UIDatePicker) -> String {
        let date = datePicker.date
        let components = Calendar.current.dateComponents([.hour, .minute], from: date)
        let hour = components.hour!
        let minute = components.minute!
        return "\(hour)\(minute)"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let placeChooseVC = segue.destination as! PlaceChooseViewController
        placeChooseVC.places = self.places
    }
}
