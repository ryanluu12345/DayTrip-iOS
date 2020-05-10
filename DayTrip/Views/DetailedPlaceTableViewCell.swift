//
//  DetailedPlaceTableViewCell.swift
//  DayTrip
//
//  Created by Ryan Luu on 5/8/19.
//  Copyright © 2019 rnluu. All rights reserved.
//

import UIKit

class DetailedPlaceTableViewCell: UITableViewCell {
    @IBOutlet weak var placeImageView: UIImageView!
    @IBOutlet weak var placeNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
