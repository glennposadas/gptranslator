//
//  String+Parser.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Foundation

extension String {
    /**
     Replaces the php-like placeholders.
     - ref: https://stackoverflow.com/questions/62361346/convert-placeholders-such-as-1s-to-x-in-swift
     */
    mutating func replacePlaceholders() {
        let regex = try! NSRegularExpression(pattern: "(?<=%)[^$s]+")
        
        let range = NSRange(location: 0, length: self.utf16.count)
        
        let matches = regex.matches(in: self, options: [], range: range)
        
        matches.forEach {
            let range = Range($0.range, in: self)!
            let new = String(self[range])
            if let newNum = Int(new) {
                let newStr = "\(newNum - 1)"
                self.replaceSubrange(range, with: newStr)
            }
        }
        
        self = self.replacingOccurrences(of: "%", with: "{")
        self = self.replacingOccurrences(of: "$s", with: "}")
    }
}
