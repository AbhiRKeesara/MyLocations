//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/5/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import UIKit
import CoreLocation

class LocationDetailsViewController: UITableViewController {
    
    var placemark: CLPlacemark?
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = ""
        categoryLabel.text = ""
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            
            addresslabel.text = stringFromPlacemark(placemark)
        } else {
            
            addresslabel.text = "No address Found"
        }
        
//        dateLabel.text = formatDate(NSDate())
        
    }
    
    func stringFromPlacemark(placemark: CLPlacemark) -> String {
        
        
        //        return "\(placemark.subThoroughfare) \(placemark.thoroughfare)\n " +
        //            "\(placemark.locality) \(placemark.administrativeArea)" +
        //        "\(placemark.postalCode)"
        
        
        var line1 = ""
        line1.addText(placemark.subThoroughfare, withSeparator: "")
        line1.addText(placemark.thoroughfare, withSeparator: " ")
        var line2 = ""
        line2.addText(placemark.locality, withSeparator: "")
        line2.addText(placemark.administrativeArea, withSeparator: " ")
        line2.addText(placemark.postalCode, withSeparator: " ")
        line2.addText(placemark.country, withSeparator: " ")
        line1.addText(line2, withSeparator: "\n")
        return line1
    }
    
    
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var categoryLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var addresslabel: UILabel!
    @IBOutlet weak var  dateLabel: UILabel!
    
    
    @IBAction func done() {
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
}
