//
//  SecondPage.swift
//  iCHEF
//
//  Created by EdwardChen on 1/11/17.
//  Copyright © 2017 iCHEF. All rights reserved.
//

import Foundation
import XCTest

class SecondPage: XCTestCase {
    
    public class func randomOrderItemsFromMenu(orderNum: Int8){
    
        let allMenuItems = app.collectionViews["orderMenuCollectionView"].cells.allElementsBoundByIndex
        
        for _ in 0...orderNum - 1 {
            
            let randomNum: Int = Int(arc4random_uniform(UInt32(allMenuItems.count)))
            allMenuItems[randomNum].tap()
            
        }
    }
    
    /**依 GridMenu 順序抓取數個品項（由上至下，由左到右）*/
    public class func additems(numberOfItem:UInt){
        additem(numberOfItem: numberOfItem)
    }
    
    public class func tapOrderItems(ItemsNum: Int) -> XCUIElement{
    
        // 點左邊側欄顧客選得項目
        let customerOrderItems = app.tables["customerOrderTableView"].cells.allElementsBoundByIndex
        let element = customerOrderItems[ItemsNum - 1]
        return element
    }
    
    public class func addPeopleButton() -> XCUIElement{
       
        makeSureCustomerFieldDisplayed()
        
        let element = app.buttons["addPeopleBtn"]
        return element
    }
    
    public class func minusPeopleButton() -> XCUIElement{
    
        makeSureCustomerFieldDisplayed()
        
        let element = app.buttons["minusPeopleBtn"]
        return element
    }
    
    public class func orderSubmitButton() -> XCUIElement{
    
        let element = app.buttons["orderSubmitButton"]
        return element
    }
    
    public class func checkOutButton() -> XCUIElement{
    
        let element = app.buttons["checkOutButton"]
        return element
    }
    
    public class func peopleCountField() -> XCUIElement{
    
        let element = app.textFields["peopleCountField"]
        return element
    }
    
    public class func inputPeopleCount(peopleCount: String){
    
        FirstPage.tapEnterNumber(enterNumber: peopleCount)
        FirstPage.KBKeyCheck().tap()
    }
    

    public class func gobackButton() -> XCUIElement{
        let element = app.buttons["backButton"]
        return element
    }

    public class func getTotalPrice() -> String{
    
        var element: String = app.staticTexts["totalOriginalPriceIdentifier"].label
        element = String(element.characters.dropFirst())
        return element
    }
    
    public class func makeSureCustomerFieldDisplayed(){
    
        let peopleButton =  app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 0).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 1).children(matching: .button).element
        
        let element = app.buttons["addPeopleBtn"]
        while element.exists == false {
            peopleButton.tap()
        }
    }
    
    public class func itemServedButton() -> XCUIElement{
    
        let element = app.buttons["CO Popover Delivered BTN"]
        return element
    }
    
    public class func itemUnServedButton() -> XCUIElement{
        
        let element = app.buttons["CO Popover Delivered BTN inUSE"]
        return element
    }
    
    public class func itemRePrintButton() -> XCUIElement{
        
        let element = app.buttons["CO Popover RePrint BTN"]
        return element
    }
    
    public class func itemEditButton() -> XCUIElement{
        
        let element = app.buttons["CO Popover Edit BTN"]
        return element
    }
    
    public class func itemDeleteButton() -> XCUIElement{
        
        let element = app.buttons["CO Popover Delete BTN"]
        return element
    }
    
    public class func dismissRegion() -> XCUIElement{
    
        let element = app.otherElements["PopoverDismissRegion"]
        return element
    }
    
}
