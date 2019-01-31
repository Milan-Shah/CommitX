//
//  Utility.swift
//  CommitX
//
//  Created by Milan Shah on 1/29/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

// Constant Tags
let ProgressIndicatorTag = 111

// Show Progress Indicator
func showProgressIndicator(view:UIView) {
    
    view.isUserInteractionEnabled = false
    let progressIndicator = ProgressIndicator(text: "Please wait...")
    progressIndicator.tag = ProgressIndicatorTag
    view.addSubview(progressIndicator)
}

// Hide Progress Indicator
func hideProgressIndicator(view:UIView){
    
    view.isUserInteractionEnabled = true
    if let progressTagView = view.viewWithTag(ProgressIndicatorTag) {
        progressTagView.removeFromSuperview()
    }
    
    
}


