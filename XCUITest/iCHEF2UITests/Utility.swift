//
//  Utility.swift
//  iCHEF
//
//  Created by EdwardChen on 1/18/17.
//  Copyright © 2017 iCHEF. All rights reserved.
//

import Foundation
import XCTest

extension XCTestCase {

// You can use
// let element = app.staticTexts["Name of your element"]
// waitForElementToAppear(object: element) { $0.exists }
   
    func waitForElementToAppear<T>(element: T, timeout: TimeInterval = 20, file: String = #file, line: UInt = #line) {
        
        let predicate = NSPredicate(format: "exists == true")
        
        expectation(for: predicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { error in
            if (error != nil) {
                let message = "Failed to fulfil expectation block for \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
    
}
