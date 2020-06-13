//
//  Parser.swift
//  GPXMLLocalizer
//
//  Created by Glenn Von Posadas on 6/13/20.
//  Copyright © 2020 GAM Dynamics. All rights reserved.
//

import Foundation

class Parser {
    
    // MARK: - Properties
    
    private var parserDelegate: ParserDelegate!
    
    private var xmlData: Data!
    var returnValue: String?
    
    // MARK: - Functions
    
    init(xmlData: Data, element: String) {
        self.xmlString = xml
        self.parserDelegate = ParserDelegate(element: element)
    }
    
    
    func parse() -> Bool{
        let data = self.xmlString.dataU
        
        let parser = XMLParser(data: data)//Parser(data: xmlString.dataUsingEncoding(.utf8, allowLossyConversion: false))
        parser.delegate = self.parserDelegate
        
        if parser.parse() {
            self.returnValue = self.parserDelegate.text
            return true
        }
        
        return false
    }
}
