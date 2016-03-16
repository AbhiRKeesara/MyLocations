//
//  LocationCell.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/15/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import UIKit

class LocationCell: UITableViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    
    func configureForLocation(location : Location) {
        
        
        if location.locationDescription.isEmpty {
            
            descriptionLabel.text = "(No Description)"
        } else {
            
            descriptionLabel.text = location.locationDescription
        }
        
        if let placemark = location.placemark {
            
            var text = ""
            text.addText(placemark.subThoroughfare)
            text.addText(placemark.thoroughfare, withSeparator: " ")
            text.addText(placemark.locality, withSeparator:  ", ")
            addressLabel.text = text
            
            
        
        } else {
            
            addressLabel.text = String(format: "Lat: %.8f, Long: %.8f", location.latitude, location.longitude)
        }
        
        }
    

    }

