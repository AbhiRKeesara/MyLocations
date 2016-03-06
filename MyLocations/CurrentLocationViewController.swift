//
//  FirstViewController.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/2/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import UIKit

import CoreLocation

class CurrentLocationViewController: UIViewController, CLLocationManagerDelegate {

    
    // store users current location in this variable
    var location: CLLocation?
    
    var updatingLocation = false
    
    // store errors from location manager
    var lastLocationError: NSError?

    
    // cllocationmanager is used to get coordinates
    let locationManager = CLLocationManager()
    
    // clgeocoder is the object that will perform the geocoding
    let geocoder = CLGeocoder()
    
    // clplacemark is the object that contain the address results
    var placemark : CLPlacemark?
    
    var performingReverseGeocoding = false
    var lastGeocodingError: NSError?
    
    // to give time out
    
    var timer: NSTimer?
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
//        self.view.backgroundColor = UIColor(patternImage: UIImage(imageLiteral: "Earth.jpg"))
        updateLabels()
        configureGetButton()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

// for display labels
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var latitudeLabel: UILabel!
    
    @IBOutlet weak var longitudeLabel: UILabel!
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    // for buttons
    @IBOutlet weak var  tagButton: UIButton!
    
    @IBOutlet weak var  getButton: UIButton!
    
    
    // when get button is pressed
    @IBAction func getLocation() {
        
        // asking authorization or permission to use the user's location first.
        
        let authStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
        
        if authStatus == .NotDetermined {
            
            locationManager.requestWhenInUseAuthorization()
            
            return
            
        }
        
        if authStatus == .Denied || authStatus == .Restricted {
            
            showLocationDeniedAlert()
            
            return
        }
        // start the location manager by using startLocationManager().
        
        if updatingLocation {
            stopLocationManager()
        } else {
            location = nil
            lastLocationError = nil
            placemark = nil
            lastGeocodingError = nil
            startLocationManager()
        }
        
        updateLabels()
        configureGetButton()
        
        
//        start the location manager with the below code as well.
//        locationManager.delegate = self
//        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
//        locationManager.startUpdatingLocation()
        
    }

   
    
    // MARK: - CLLocationManagerDelegate
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        
        print("didFailWithError \(error)")
        
        
        if error.code == CLError.LocationUnknown.rawValue {
            
            return
        }
        
        lastLocationError = error
        
        stopLocationManager()
        
        updateLabels()
        configureGetButton()
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
        let newLocation = locations.last! as CLLocation
        
        print("didUpdateLocations \(newLocation)")
        
        if newLocation.timestamp.timeIntervalSinceNow < -5 {
            
            return
        }
        
        if newLocation.horizontalAccuracy < 0 {
            
            return
        }
        
        var distance = CLLocationDistance(DBL_MAX)
        
        if let location = location {
            
            distance = newLocation.distanceFromLocation(location)
        }
        
        if location == nil || location!.horizontalAccuracy > newLocation.horizontalAccuracy {
            
        // clears if there are any previous errors
        lastLocationError = nil 
        
        // stores the new location object
        location = newLocation
            
        updateLabels()
        
            if newLocation.horizontalAccuracy <= locationManager.desiredAccuracy {
                
                print("*** We're done!")
                stopLocationManager()
                configureGetButton()
                
                if distance > 0 {
                    
                    performingReverseGeocoding = false
                }
            }
        
            // checking to perform geocoding
            
            if !performingReverseGeocoding {
                
                print("**** Going to geocode")
                
                performingReverseGeocoding = true
                
                geocoder.reverseGeocodeLocation(location!, completionHandler: { placemarks, error in
                    
                print("**** Found placemarks: \(placemarks),error: \(error)")
                
                self.lastGeocodingError = error
                    
                    if error == nil && !placemarks!.isEmpty {
                        self.placemark = placemarks!.last! as CLPlacemark
                    } else {
                        
                        self.placemark = nil
                    }
                    
                    self.performingReverseGeocoding = false
                    self.updateLabels()
                })
            }
            
        } else if distance < 1.0 {
            
            let timeInterval = newLocation.timestamp.timeIntervalSinceDate(location!.timestamp)
        
        
        if timeInterval > 10 {
            print("*** Force done!")
            stopLocationManager()
            updateLabels()
            configureGetButton()
            
            }
            
        }
    }

    // method to show that the permission to use the location services had been denied
    
    func showLocationDeniedAlert() {
        
        let alert = UIAlertController(title: "Location Services Disabled", message:"Please enable location services for this app in settings", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default, handler: nil)
        
        alert.addAction(okAction)
        
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    // method for update labels
    
    func updateLabels() {
        
        if let location = location {
            
            latitudeLabel.text = String(format: "%.8f", location.coordinate.latitude)
            longitudeLabel.text = String(format: "%.8f", location.coordinate.longitude)
            tagButton.hidden = false
            messageLabel.text = ""
            
            if let placemark = placemark {
                
                addressLabel.text = stringFromPlacemark(placemark)
            } else if performingReverseGeocoding {
                
                addressLabel.text = "Searching for Address"
            } else if lastGeocodingError != nil {
                
                addressLabel.text = "Error Finding Address"
            } else {
                
                addressLabel.text = " No Address Found"
            }
            
        } else {
            
            latitudeLabel.text = ""
            longitudeLabel.text = ""
            addressLabel.text = ""
            tagButton.hidden = true
            
            var statusMessage: String
            
            if let error = lastLocationError {
                
                if error.domain == kCLErrorDomain && error.code == CLError.Denied.rawValue {
                    
                    statusMessage = "Location Services Disabled"
                } else {
                    
                    statusMessage = "Error Getting Location"
                }
                
            } else if !CLLocationManager.locationServicesEnabled() {
                
                statusMessage = " Location Services Disabled"
                
            } else if updatingLocation{
                
                statusMessage = "Searching..."
            } else {
                
                statusMessage = "Tap 'Get My Location' to start"
            }
            
            messageLabel.text = statusMessage
            
        }
    
    }
    
    // method to start location manager.
    
    func startLocationManager() {
        
        if CLLocationManager.locationServicesEnabled() {
            
            locationManager.delegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
            updatingLocation = true
            
            timer = NSTimer.scheduledTimerWithTimeInterval(60, target: self, selector: Selector("didTimeOut"), userInfo: nil, repeats: false)
            
        }
    
    }
    
    
    // method to stop the location manager if it cannot ge the location.
    
    func stopLocationManager() {
        
        if updatingLocation {
            
            if let timer = timer {
                
                timer.invalidate()
            }
            
            locationManager.stopUpdatingLocation()
            locationManager.delegate = nil
            updatingLocation = false
        }
        
    }
    
    // method to let user show stop on the getmylocation button when the location search is going on.
    
    
    func configureGetButton() {
        
        if updatingLocation {
            
            getButton.setTitle("Stop", forState: .Normal)
           
            
        } else {
            
            getButton.setTitle("Get My Location", forState: .Normal)
            
        }
        
    }
    
    // method to convert placemark object in to string to display
    
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
        line1.addText(line2, withSeparator: "\n")
        return line1
    }
    
    
    // method for time out didTimeOut
    
    func didTimeOut() {
        
        print("*** Time out")
        
        if location == nil {
            
            stopLocationManager()
            
            lastLocationError = NSError( domain: "MyLocationsErrorDomain", code: 1, userInfo: nil)
            
            updateLabels()
            configureGetButton()
        }
        
    }
    
        // method for addText
        func addText(text: String?, toLine line: String, withSeparator separator: String) -> String {
            var result = line
            if let text = text {
                if !line.isEmpty {
                    result += separator
                }
                result += text
            }
            
            return result
        }
    }
        
        


