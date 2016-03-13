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

class Location: NSManagedObject {
    

// Insert code here to add functionality to your managed object subclass

    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var placemark: CLPlacemark?
    @NSManaged var locationDescription: String
    @NSManaged var date: NSDate

}
