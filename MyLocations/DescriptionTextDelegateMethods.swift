//
//  DescriptionTextDelegateMethods.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/12/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import Foundation
import UIKit


extension LocationDetailsViewController : UITextViewDelegate {
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        
        descriptionText = (textView.text as NSString).stringByReplacingCharactersInRange( range, withString: text)
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        
        descriptionText = textView.text
    }
    
}