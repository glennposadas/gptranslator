//
//  DIRManager.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/14/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Foundation

struct DIRManager {
    static var desktopPath: URL {
        FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}
