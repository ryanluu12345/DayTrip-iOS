//
//  ItineraryListViewController.swift
//  DayTrip
//
//  Created by Ryan Luu on 5/7/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit

class ItineraryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    var itineraryList: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getInitialItineraries()
    }
    
    func getInitialItineraries() {
        PlacesAPICaller().getItinerariesList() {
            itineraries in
            print(itineraries)
            self.itineraryList = itineraries
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itineraryList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "itineraryCell") as! ItineraryListTableViewCell
        //Replace with the actual itinerary label for the specific indexpath
        cell.itineraryLabel.text = itineraryList[indexPath.row]["itineraryName"] as? String ?? ""
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailedTableViewCell = sender as! ItineraryListTableViewCell
        let indexPath = tableView.indexPath(for: detailedTableViewCell)
        let destination = segue.destination as! SpecificItineraryViewController
        destination.places = itineraryList[indexPath!.row]["itinerary"] as! [String: Any]
    }
}
