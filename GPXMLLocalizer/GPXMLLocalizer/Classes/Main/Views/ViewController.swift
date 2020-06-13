//
//  ViewController.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Cocoa

//TODO: Make VMs.

/**
 The main controller of the application.
 */
class ViewController: NSViewController {
    
    // MARK: - Properties
    
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
    
    private func setupUI() {
        self.loader.alphaValue = 0
    }
    
    private func buildFiles() {
        var content = ""
        
        var pairs = [String]()
        
        for (index, key) in self.englishKeys.enumerated() {
            let value = self.englishValues[index]
            print("KEY: \(key) | VALUE: \(value)")
            
            let newKeyValuePair = "\(key) = \(value)"
            pairs.append(newKeyValuePair)
        }
        
        content = pairs.joined(separator: "\n")
        
        let savePanel = NSSavePanel()
        savePanel.nameFieldStringValue = "lala.txt"
        savePanel.canCreateDirectories = true
        savePanel.allowedFileTypes = ["txt"]
        
        if savePanel.runModal() == NSApplication.ModalResponse.OK {
            
            let entryPath = savePanel.url
            
            do {
                try content.write(to: entryPath!, atomically: true, encoding: String.Encoding.utf8)
                self.handleSuccess()
            } catch {
                print(error.localizedDescription)
                self.showFileWriteError()
            }
        }
    }
    
    private func handleSuccess() {
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
    
    // MARK: IBActions
    
    @IBAction func generate(_ sender: Any) {
        let first = self.englishPaths.first!
        let parser = XMLParser(contentsOf: first)
        parser?.delegate = self
        parser?.parse()
    }
    
    @IBAction func selectEnglishFiles(_ sender: NSButton) {
        self.selectFiles { urls in
            self.englishPaths = urls
        }
    }
    
    @IBAction func selectItalianFiles(_ sender: NSButton) {
        self.selectFiles { urls in
            self.italianPaths = urls
        }
    }
}

// MARK: - XMLParserDelegate

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
        self.buildFiles()
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        var value = string
        if value.isValidValue {
            value.replacePlaceholders()
            self.englishValues.append(value)
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        guard let key = attributeDict["name"],
            !key.isEmpty else { return }
        self.englishKeys.append(key)
    }
}
