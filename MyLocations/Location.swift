//
//  MyLocationsLocation.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/13/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import MapKit


@objc(Location)
class Location: NSManagedObject, MKAnnotation {
    

// Insert code here to add functionality to your managed object subclass

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var placemark: CLPlacemark?
    @NSManaged var locationDescription: String
    @NSManaged var date: NSDate

    
    var title: String? {
        
        if locationDescription.isEmpty {
            
            return ""
        } else {
            return locationDescription
        }
    }
  
    
var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    

}
    

