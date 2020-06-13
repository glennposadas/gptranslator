//
//  NSViewControllerExtension.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/14/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Cocoa

typealias SelectedFilesBlock = ((_ urls: [URL]) -> Void)?

extension NSViewController {
    func showCompletionAlert() {
        self.showAlert(
            message: "Success parsing!",
            infoText: "You may see the output in your desktop folder.",
            style: .informational
        )
    }
    
    func showFileWriteError() {
        self.showAlert(
            message: "Error saving file.",
            infoText: "An error has occured while attmeping to save data to text files. Please check your permission settings.",
            style: .critical
        )
    }
    
    func showAlert(message: String, infoText: String, style: NSAlert.Style) {
        let alert = NSAlert()
        alert.messageText = message
        alert.informativeText = infoText
        alert.addButton(withTitle: "OK")
        alert.alertStyle = .informational
        
        var w: NSWindow?
        if let window = view.window {
            w = window
        } else if let window = NSApplication.shared.windows.first {
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
    
    func selectFiles(fileTypes: [String] = ["xml"], withBlock completion: SelectedFilesBlock) {
        let dialog = NSOpenPanel()
        dialog.title = "Choose your .xml files"
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = true
        dialog.allowedFileTypes = fileTypes
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.urls
            completion?(result)
            return
        }
        
        completion?([])
    }
}
