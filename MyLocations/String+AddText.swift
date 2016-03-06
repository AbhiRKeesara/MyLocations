//
//  String+AddText.swift
//  MyLocations
//
//  Created by abhinay reddy keesara on 3/5/16.
//  Copyright © 2016 abhinay reddy keesara. All rights reserved.
//

import Foundation

extension String {
    mutating func addText(text:String?, withSeparator separator:String = "") {
        if let text = text {
            if !isEmpty {
                self += separator
            }
            self += text
        }
    }
}