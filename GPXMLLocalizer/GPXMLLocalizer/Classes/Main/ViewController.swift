//
//  ViewController.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {
    
    // MARK: - Properties
    
    typealias SelectedFilesBlock = ((_ urls: [URL]) -> Void)?
    
    private var englishPaths = [URL]()
    private var italianPaths = [URL]()
    
    // MARK: - Functions
    // MARK: Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    private func handleSelectionOfFiles(withBlock completion: SelectedFilesBlock) {
        let dialog = NSOpenPanel()
        dialog.title = "Choose a .xml files"
        dialog.canCreateDirectories = true
        dialog.allowsMultipleSelection = true
        dialog.allowedFileTypes = ["xml"]
        
        if (dialog.runModal() == NSApplication.ModalResponse.OK) {
            let result = dialog.urls
            completion?(result)
            return
        }

        completion?([])
    }
    
    // MARK: IBActions
    
    @IBAction func selectEnglishFiles(_ sender: NSButton) {
        self.handleSelectionOfFiles { urls in
            self.englishPaths = urls
        }
    }
    
    @IBAction func selectItalianFiles(_ sender: NSButton) {
        self.handleSelectionOfFiles { urls in
            self.italianPaths = urls
        }
    }
}

