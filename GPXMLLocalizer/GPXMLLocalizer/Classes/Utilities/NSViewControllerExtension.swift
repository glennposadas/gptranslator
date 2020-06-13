//
//  NSViewControllerExtension.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/14/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Cocoa

extension NSViewController {
    func showCompletionAlert() {
        let alert = NSAlert()
        alert.messageText = "Success parsing!"
        alert.informativeText = "You may see the output in your desktop folder."
        alert.addButton(withTitle: "OK")
        alert.alertStyle = .informational
        
        var w: NSWindow?
        if let window = view.window {
            w = window
        }
        else if let window = NSApplication.shared.windows.first {
            w = window
        }
        if let window = w {
            alert.beginSheetModal(for: window){ (modalResponse) in
                if modalResponse == .alertFirstButtonReturn {
                    print("Document deleted")
                }
            }
        }
    }
}
