//
//  HUDView.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/12/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import UIKit

class HUDView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var text = ""
    
    class func hudInView(view: UIView, animated: Bool) -> HUDView {
        
        let hudView = HUDView(frame: view.bounds)
        
        hudView.opaque = false
        view.addSubview(hudView)
        view.userInteractionEnabled = false
        
        return hudView
        
    }

}
