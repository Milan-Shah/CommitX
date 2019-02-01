//
//  Extensions.swift
//  CommitX
//
//  Created by Milan Shah on 1/30/19.
//  Copyright © 2019 Milan Shah. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    func getFormattedDateString() -> String? {
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" //"2018-12-12T20:45:21Z"
        guard let date = dateFormatter.date(from: self) else {
            return nil
        }
        dateFormatter.dateFormat = "dd-MM-YYYY"
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    func removeSpaces() -> String {
        var string = self
        string = string.replacingOccurrences(of: " ", with: "")
        string = string.replacingOccurrences(of: "\n", with: " ")
        return string
    }
}


