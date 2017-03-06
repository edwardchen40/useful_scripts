//
//  ThirdPageObjects.swift
//  iCHEF
//
//  Created by EdwardChen on 1/17/17.
//  Copyright © 2017 iCHEF. All rights reserved.
//

import Foundation
import XCTest

class ThirdPage: XCTestCase {

    public class func cleanItemsFromCheckListButton() -> XCUIElement{
    
        let element = app.buttons["checkoutAllButton"]
        return element
    }
    
    public class func enterPaymentButton() -> XCUIElement{
    
        let element = app.buttons["enterPaymentButton"]
        return element
    }
    
    public class func goBackButton() -> XCUIElement{
    
        let element = app.buttons["backButton"]
        return element
    }
    
    /**Add addSplitCheckButton on upper-right*/
    public class func addSplitCheckButton() -> XCUIElement{
    
        let element = app.buttons["addSplitCheckButton"]
        return element
    }
    
    public class func useDiscountFiftyOff() -> XCUIElement{
    
        // Select 50% off discount
        let element = app.tables
        return element.cells.switches["全單折扣 5 折"]
    }
    
    public class func useDiscountRebate100Yen() -> XCUIElement{
    
        // Select rebate for $100
        let element = app.tables
        return element.cells.switches["全單折讓 100 元"]
    }
    
    public class func getTotalUnpaidPrice() -> String{
        
        var element: String = app.staticTexts["totalCheckoutPriceIdentifier"].label
        element = String(element.characters.dropFirst())
        return element
    }

}

    
