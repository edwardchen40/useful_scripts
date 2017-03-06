//
//  FirstPageObjects.swift
//  iCHEF
//
//  Created by EdwardChen on 1/3/17.
//  Copyright © 2017 iCHEF. All rights reserved.
//

import Foundation
import XCTest

let window = app.children(matching: .window).element(boundBy: 0)
// var element: XCUIElement? = nil

class FirstPage: XCTestCase {
    
    public class func openTakeoutButton() -> XCUIElement {
        
        let element = app.buttons["Waitline OpenTakeout BTN"]
      //  element.tap()
        return element
    }
    
    public class func addTakeoutButton() -> XCUIElement{
        
        let element = app.buttons["Waitline AddTakeout BTN"]
        return element
    }
    
    public class func openLineupButton() -> XCUIElement{
        
        let element = app.buttons["Waitline OpenLineup BTN"]
        return element
    }
    
    public class func addLineupButton() -> XCUIElement{
    
        let element = app.buttons["Waitline AddLineup BTN"]
        return element
    }
    
    public class func enterCustomerName(customerName: String){
    
        let customerNameTextField = app.textFields["Customer Name"]
        customerNameTextField.tap()
        customerNameTextField.typeText(customerName)
    }
    
    public class func enterPhoneNumber(phoneNumber: String){
        
        app.textFields["Phone Number"].tap()
        let phoneNumArray = phoneNumber.characters.map { String($0) }
        for count in 0 ..< phoneNumArray.count {
            
            app.buttons["key\(phoneNumArray[count])"].tap()
        }
    }
    
    public class func enterNote(note: String){
        
        let noteTextField = app.textFields["Note"]
        noteTextField.tap()
        noteTextField.typeText(note)
    }
    
    
    public class func KBKeyBack() -> XCUIElement{
    
        let element = app.buttons["keyBack"]
        return element
        
    }
    
    public class func KBKeyNext() -> XCUIElement{
        
        let element = app.buttons["keyNext"]
        return element
        
    }
    
    public class func KBKeyStar() -> XCUIElement{
        
        let element = app.buttons["keyStar"]
        return element
    }
    
    public class func KBKeyNumbersign() -> XCUIElement{
        
        let element = app.buttons["keyNumber"]
        return element
    }
    
    public class func KBKeyHide() -> XCUIElement{
        
        let element = app.buttons["keyHide"]
        return element
    }
    
    public class func KBKeyCheck() -> XCUIElement{
    
        let element = app.buttons["keySave"]
        return element
    }
    
    public class func waitingLineAddPersonButton() -> XCUIElement{
        
        let waitlineAddlineupPopoverPeoButton = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 5).children(matching: .button).matching(identifier: "Waitline AddLineup Popover Peo").element(boundBy: 1)
        
        return waitlineAddlineupPopoverPeoButton
    
    }
    
    public class func waitingLineSubPersonButton() -> XCUIElement{
    
        let waitlineSublineupPopoverPeoButton = window.children(matching: .other).element(boundBy: 1).children(matching: .other).element(boundBy: 2).children(matching: .other).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 5).children(matching: .button).matching(identifier: "Waitline AddLineup Popover Peo").element(boundBy: 0)
        
        return waitlineSublineupPopoverPeoButton

    }
    
    public class func tapEnterNumber(enterNumber: String){
        
        let enterNumArray = enterNumber.characters.map { String($0) }
        for count in 0 ..< enterNumArray.count {
            
            app.buttons["key\(enterNumArray[count])"].tap()
        }
        
        /*
        for character in enterNumber.characters {
            app.buttons["key\(character)"].tap()
        }
         */
    }
    
    public class func waitLineEditConfirmButton() -> XCUIElement{
        let  element = app.buttons["Confirm"]
		return element
    }
    
    public class func numberOfCustomersField() -> XCUIElement{
    
        let element = app.textFields["Enter number of customers"]
        return element
    }
    
    public class func ToolBox() -> XCUIElement{
    
        let element = app.buttons["toolBoxButton"]
        return element
        
    }
    
    public class func systemInfoWithinTooBox() -> XCUIElement{
    
        let element = app.collectionViews.images["Toolbox_Popover_SystemInfo-ICON"]
        return element
    }
    
    public class func cashDrawerWithinTooBox() -> XCUIElement{
        
        let element = app.collectionViews.images["Toolbox_Popover_CashDrawer-ICON"]
        return element
    }
    
    public class func openCaseDrawer() -> XCUIElement{
    
        let element = app.staticTexts["Open Cash Drawer"]
        return element
    }
    
    public class func receiptRecordWithinTooBox() -> XCUIElement{
        
        let element = app.collectionViews.images["Toolbox_Popover_CheckoutRecords-ICON"]
        return element
    }
    
    /*
     public static void tapClockInAndOutWithinTooBox() {
     
     }
     */
    public class func clockInAndOutWithinTooBox() -> XCUIElement{
        
        let element = app.collectionViews.images["Toolbox_Popover_TimeClock-ICON"]
        return element
    }

    /*
    public static XCUIElement tapPrinterSettingWithinTooBox() {
    
    }
     */
    public class func printerSettingWithinTooBox() -> XCUIElement {
        let element = app.collectionViews.images["Toolbox_Popover_PrinterManager-ICON"]
        return element
    }
    
    public class func printerActionSetingAndNotSetting(){
    
        let printerName = ["麵與水餃", "1F顧客聯印表機", "收據印表機"]
        let element = app.tables
        for i in 0 ... printerName.count - 1 {
            
            element.cells.containing(.staticText, identifier: printerName[i]).staticTexts["Not Set"].tap()
            element.staticTexts["00:11:62:06:68:1e [TCP:192.168.0.140]"].tap()
            element.cells.containing(.staticText, identifier: printerName[i]).staticTexts["00:11:62:06:68:1e"].tap()
            element.staticTexts["Do not select printer"].tap()
        }
        app.buttons["TC CloseTCPopover BTN"].tap()
    }
    
    public class func shiftAndCloseWithinTooBox() -> XCUIElement{
        
        let element = app.collectionViews.images["Toolbox_Popover_DailyAccount-ICON"]
        return element
    }
    
    public class func chooseTables(tableID: String, tableNum: Int8) -> XCUIElement{
        
        let element = app.buttons["\(tableID)\(tableNum)_addButton"]
        return element
    
    }
    
    public class func deleteCGFromTable(tableID: String, tableNum: Int8){
        
        let toolBoxBtn = app.buttons["toolBoxButton"]
        let element = app.buttons["\(tableID)\(tableNum)_addButton"]
        element.press(forDuration: 1, thenDragTo: toolBoxBtn)
    }
    
    /**內用單、排隊單未點餐、未出單下半部白色區塊*/
    public class func redCGNoText() -> XCUIElement{
    
        let element = app.images["CustomerGroup_R-NoText"]
        return element
    }
    
    /**內用單、排隊單已點餐、未出單下半部白色區塊*/
    public class func redCGText() -> XCUIElement{
    
        let element = app.images["CustomerGroup_R-Text"]
        return element
    }

    /**內用單、排隊單已出單、未出餐、未結帳下半部白色區塊*/
    public class func yellowCGText() -> XCUIElement{
    
        let element = app.images["CustomerGroup_Y-Text"]
        return element
    
    }
    
    /**內用單、排隊單全單已出餐、未結帳下半部白色區塊*/
    public class func greenCGText() -> XCUIElement{
    
        let element = app.images["CustomerGroup_G-Text"]
        return element
    }
    
    /**內用單、排隊單全單未出餐、已結帳下半部白色區塊*/
    public class func yellowCGTextCheckOut() -> XCUIElement{
    
        let element = app.images["CustomerGroup_Y-TextCheckout"]
        return element
    }
    
    /**內用單、排隊單全單已出餐、已結帳下半部白色區塊*/
    public class func blueCGTextCheckOut() -> XCUIElement{
        
        let element = app.images["CustomerGroup_SG-TextCheckout"]
        return element
    }
    
   /**外帶單未點餐、未出單下半部白色區塊*/
    public class func redCGTakeOutNoText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_R-NoText"]
        return element
    }

    /**外帶單已點餐、未出單下半部白色區塊*/
    public class func redCGTakeOutText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_R-Text"]
        return element
    }

    /**外帶單已出單、未出餐、未結帳下半部白色區塊*/
    public class func yellowCGTakeOutText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_Y-Text"]
        return element
    }
    
    /**外帶單全單未出餐、已結帳下半部白色區塊*/
    public class func yellowCGTakeOutChecOutText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_Y-TextCheckout"]
        return element
    }
    
    /**外帶單全單已出餐、未結帳下半部白色區塊*/
    public class func greenCGTakeOutText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_G-Text"]
        return element
    }
    
    /**外帶單全單已出餐、已結帳下半部白色區塊*/
    public class func blueCGTakeOutCheckOutText() -> XCUIElement{
    
        let element = app.images["CustomerGroup-Takeout_SG-TextCheckout"]
        return element
    }
    /**指定桌位刪除不含半結狀態的 紅、黃、綠 CG */
    public class func deleteCGFromTable(_ table:String){
        deletAllCustomerGroupFromTables(fromTable: table)
    }
    
    public class func addButtonFromTable( table : String ) -> XCUIElement{
        let element = app.buttons["\(table)_addButton"]
        return element
    }
    
    public class func confirmCGDeprtureText() -> XCUIElement{
    
        let element = app.staticTexts["Confirm customer departure with payment pending"]
        return element
    }
    
    public class func confirmCGDeprturCancelButton() -> XCUIElement{
    
        let element = app.buttons["Cancel"]
        return element
    }
    
    public class func verifyUserNameAfterTapAuthPassword( user: String, authPwd: String){
    
        for i in authPwd.characters{
        
            let element = app.buttons["Auth_key\(i)Btn"]
            element.tap()
        }

        XCTAssertEqual(app.tables.staticTexts["admin"].label
, user, "The user name [ \(user) ] is different with \(app.tables.staticTexts["admin"].label).")
        
    }
}


