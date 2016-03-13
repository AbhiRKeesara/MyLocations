//
//  LocationDetailsViewController.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/5/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData



private let dateFormatter: NSDateFormatter = {
    let formatter = NSDateFormatter()
    formatter.dateStyle = .MediumStyle
    formatter.timeStyle = .ShortStyle
    return formatter
    
}()

class LocationDetailsViewController: UITableViewController {
    
    
    var managedObjectContext: NSManagedObjectContext!
    
    var placemark: CLPlacemark?
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    
    // to store description text
    var descriptionText = ""
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        descriptionTextView.text = descriptionText
        
        
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            
            addresslabel.text = stringFromPlacemark(placemark)
        } else {
            
            addresslabel.text = "No address Found"
        }
        
        dateLabel.text = formatDate(NSDate())
        
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
        
//        dismissViewControllerAnimated(true, completion: nil)
    
        print("Desciption '\(descriptionText) ")
        let hudView = HUDView.hudInView(navigationController!.view, animated: true)
        hudView.text = " Tagged"
      //  hudView.backgroundColor = UIColor.blueColor()
        hudView.showAnimated(true)
        
        afterDelay(0.6) {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func cancel() {
        
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    // method to format date from NSDate to string
    func formatDate(date: NSDate) -> String{
        
        return dateFormatter.stringFromDate(date)
        
    }
    
    // MARK: - UITableViewDelegate
    
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
    
        if indexPath.section == 0 && indexPath.row == 0 {
            
            return 88
        } else if indexPath.section == 2 && indexPath.row == 2 {
            
            
            addresslabel.frame.size = CGSize(width: view.bounds.size.width - 115 , height: 10000)
            
            addresslabel.sizeToFit()
            addresslabel.frame.origin.x = view.bounds.size.width - addresslabel.frame.size.width - 15
            return addresslabel.frame.size.height + 20
        } else {
            
            return 44
        }
    }
    
    
   
    
    
   
}
