//
//  Functions.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/13/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import Foundation

import Dispatch


func afterDelay( seconds: Double , closure: () -> ()) {
    
    
    let when = dispatch_time(DISPATCH_TIME_NOW, Int64(seconds * Double(NSEC_PER_SEC)))
    
    dispatch_after(when, dispatch_get_main_queue(), closure)
}