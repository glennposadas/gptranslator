//
//  ViewController.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Cocoa

/**
 The main controller of the application.
 */
class ViewController: NSViewController {
    
    // MARK: - Properties
    
    typealias SelectedFilesBlock = ((_ urls: [URL]) -> Void)?
    
    private var englishPaths = [URL]()
    private var italianPaths = [URL]()
    
    private var englishDictionary = [String : Any]()
    private var englishKeys = [String]()
    private var englishValues = [String]()
    
    // MARK: Views
    
    @IBOutlet weak var selectEnglishFilesBtn: NSButton!
    @IBOutlet weak var selectItalianFilesBtn: NSButton!
    @IBOutlet weak var generateBtn: NSButton!
    @IBOutlet weak var loader: NSProgressIndicator!
    
    // MARK: - Functions
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupUI()
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
    
    private func setupUI() {
        self.loader.alphaValue = 0
    }
    
    private func showCompletionAlert() {
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
    
    // MARK: IBActions
    
    @IBAction func generate(_ sender: Any) {
        let firstURL = self.englishPaths.first!
        let parser = XMLParser(contentsOf: firstURL)
        parser?.delegate = self
        parser?.parse()
    }
    
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

extension ViewController: XMLParserDelegate {
    func parserDidStartDocument(_ parser: XMLParser) {
        self.generateBtn.wantsLayer = true
        self.loader.wantsLayer = true
        self.loader.startAnimation(self)
        
        NSAnimationContext.runAnimationGroup({ context in
            context.duration = 0.3
            self.loader.alphaValue = 1.0
        }, completionHandler: {
            self.generateBtn.alphaValue = 0
        })
    }
    
    func parserDidEndDocument(_ parser: XMLParser) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            self.generateBtn.wantsLayer = true
            self.loader.wantsLayer = true
            self.loader.stopAnimation(self)
            
            NSAnimationContext.runAnimationGroup({ context in
                context.duration = 0.3
                self.generateBtn.alphaValue = 1.0
            }, completionHandler: {
                self.loader.alphaValue = 0
                self.showCompletionAlert()
            })
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("Found characters!!! \(string)")
        self.englishValues.append(string)
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard let key = attributeDict["name"] else { return }
        self.englishKeys.append(key)
    }
    
    
}
