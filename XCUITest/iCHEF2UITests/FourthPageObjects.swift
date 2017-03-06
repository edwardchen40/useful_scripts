//
//  FourthPageObjects.swift
//  iCHEF
//
//  Created by EdwardChen on 1/17/17.
//  Copyright © 2017 iCHEF. All rights reserved.
//

import Foundation
import XCTest

class FourthPage: XCTestCase {

    public class func swipeCheckBar() {
    
        let element = app.otherElements["checkOutInvoiceSwiper"].children(matching: .other).element
        element.swipeRight()
    }
    
    public class func waitCheckOutSuccessPopUp() -> XCUIElement{
        
        let element = app.otherElements["iCHEFAlertViewBackground"].staticTexts["Payment complete"]
        return element
        
    }
    
    public class func tapCheckOutSuccessPopUp() -> XCUIElement{
        
        let element = app.otherElements["iCHEFAlertViewBackground"].staticTexts["Payment complete"]
        return element
    }
    
    public class func selectPaymentMethod(paymentMethod: String) -> XCUIElement{
        
        let element = app.tables["paymentModuleTableView"]
        var paymentMethod = paymentMethod.lowercased()
        
        switch paymentMethod {
        case "card" :
            return element.staticTexts["Credit card"]
        case "mpos" :
            return element.staticTexts["mPOS"]
        case "twinvoice":
            return element.staticTexts["Taiwan invoice options"]
        default:
            return element.staticTexts["Cash"]
        }
    }
    
    public class func selectVISA() -> XCUIElement{
        
        let element = app.tables["paymentModuleTableView"].buttons["Credit card: visa"]
        return element
    }
    
    public class func selectMaster() -> XCUIElement{
        
        let element = app.tables["paymentModuleTableView"].buttons["Credit card: master"]
        return element
    }
    
    public class func enterLast4Digits(digits: String){
    
        let element = app.textFields["Enter credit card last 4 digit"]
        element.tap()
        element.typeText(digits)
    }
    
    public class func enterCardPaymentNotes(){
    
//        let paymentNoteTextField = app.tables["paymentModuleTableView"].cells.containing(.staticText, identifier:"Credit card").textFields["Payment note"]
//        
//        paymentNoteTextField.typeText("This is QE test")
        
        
        let element = app.textFields.matching(identifier: "Add some notes")
                   // We take the first one and tap it
        let cardSeriesButton = element.element(boundBy: 1)
        cardSeriesButton.tap()

        app.keys["T"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.buttons["Done"].tap()
        
    }
    
    public class func selectJCB() -> XCUIElement{
        
        let element = app.tables["paymentModuleTableView"].buttons["Credit card: jcb"]
        return element
    }
    
    public class func selectChinaUnion() -> XCUIElement{
        
        let element = app.tables["paymentModuleTableView"].buttons["Credit card: china_union"]
        return element
    }
    
    
    public class func goBackButton() -> XCUIElement{
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .button).element
        return element
    }
    
    public class func KBKeyHide() -> XCUIElement{
        
        let element = app.buttons["keyHide"]
        return element
    }
    
    public class func enterCashPaymentNotes(){
        
        let element = app.textFields.matching(identifier: "Add some notes")
        // We take the first one and tap it
        let cardSeriesButton = element.element(boundBy: 0)
        cardSeriesButton.tap()
        
        app.keys["T"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.buttons["Done"].tap()
    }
    
    public class func enterMposPaymentNotes(){
        
        let element = app.textFields.matching(identifier: "Add some notes")
        // We take the first one and tap it
        let cardSeriesButton = element.element(boundBy: 2)
        cardSeriesButton.tap()
        
        app.keys["T"].tap()
        app.keys["e"].tap()
        app.keys["s"].tap()
        app.keys["t"].tap()
        app.buttons["Done"].tap()
    }
    
//    public class func swipeCheckOut(){
//    
//        let element = app.otherElements["checkOutInvoiceSwiper"].children(matching: .other).element
//        element.swipeRight()
//        
//        let changeWord = app.otherElements["iCHEFAlertViewBackground"].staticTexts["Change"]
//        waitForElementToAppear(element: changeWord, timeout: 20)
//        changeWord.tap()
//        
//    }
}
