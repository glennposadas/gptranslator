//
//  String+Parser.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Foundation

extension String {
    /// Validates the value. TODO: Use Regex.
    var isValidValue: Bool {
        print(self)
        if self.isEmpty || self == "\n    " || self == "\n\t" {
            return false
        }
        
        return true
    }
    
    /**
    Replaces the php-like placeholders.
    - ref: https://stackoverflow.com/questions/62361346/convert-placeholders-such-as-1s-to-x-in-swift
    */
    mutating func replacePlaceholders() {
        let pattern = #"%(\d*)\$s"#
        var range = self.range(of: pattern, options: .regularExpression)

        while range != nil {
            let placeholder = self[range!]
            let number = placeholder.trimmingCharacters(in: CharacterSet(charactersIn: "0123456789.").inverted)

            if let value = Int(number) {
                self = self.replacingOccurrences(of: placeholder, with: "{\(value - 1)}")
            }
            range = self.range(of: pattern, options: .regularExpression)
        }
    }
}
