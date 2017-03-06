//
//  SmokeTestCase.swift
//  iCHEF
//
//  Created by TrevorLee on 2017/1/13.
//  Copyright © 2017年 iCHEF. All rights reserved.
//

import Foundation
import XCTest

class iCHEF2UISmokeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
        
        super.tearDown()
    }
    
    let smokeTestRestaurantID = "smokeTestRestaurantID"
    let smokeTestUserID = "smokeTestUserID"
    let smokeTestPassword = "smokeTestPassword"
    let timeConfirmationAlert = XCUIApplication().alerts["Time Confirmation"]
    
    public func login(){
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
    }
    
    /**可成功安裝 app，且可以啟動並登入*/
    public func testCaseC355(){
        login()
    }
    
    /**可建立外帶單(未包含client)*/
    public func testCaseC356(){
        
        login()
        
        let toolbox = app.buttons["toolBoxButton"]
        
        //如果 TakeoutButton 預設未開啟，則點擊 TakeoutButton
        if(!FirstPage.addTakeoutButton().exists){
            FirstPage.openTakeoutButton().tap()
        }
        
        FirstPage.addTakeoutButton().tap()
        
        //Get back to the FirstPage then distroy the CG
        SecondPage.gobackButton().tap()
        FirstPage.redCGTakeOutNoText().press(forDuration: 0, thenDragTo: toolbox)
        app.buttons["Delete"].tap()
        
    }
    
    /**輸入顧客人數建立排隊單(未包含client)*/
    public func testCaseC357(){
       
        login()
        
        let toolbox = app.buttons["toolBoxButton"]
        FirstPage.addLineupButton().tap()
        FirstPage.waitingLineAddPersonButton().tap()
        FirstPage.waitLineEditConfirmButton().tap()
        FirstPage.redCGNoText().press(forDuration: 0, thenDragTo: toolbox)
        app.buttons["Delete"].tap()
    }
    
    /** 在空桌子建立新顧客單，且在出單後進行修改或註銷，確認出單正確 */
    func testCaseC358(){
    
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // If time confirmation alert is displayed, click "Confirm"
        sleep(10)
        if timeConfirmationAlert.exists{
            LoginPage.ifTimeConfirmationAlertIsDisplay()
        }
        else{
            waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        }
        
        // Choose table
        FirstPage.chooseTables(tableID: "T", tableNum: 1).doubleTap()
        
        // Choose order
        SecondPage.randomOrderItemsFromMenu(orderNum: 1)
        
        // Add people
        SecondPage.addPeopleButton().tap()
        
        // Submit order
        SecondPage.orderSubmitButton().tap()
        
        // Assert yellow CG has been created.
        XCTAssertEqual(FirstPage.yellowCGText().exists, true, "The CG has been created and submitted.")
        
        // Double click yellow CG
        FirstPage.yellowCGText().doubleTap()
        
        // Tap the order
        SecondPage.tapOrderItems(ItemsNum: 1).tap()
        
        // Tap delete
        SecondPage.itemDeleteButton().tap()
        
        // Tap area by up to you
        SecondPage.dismissRegion().tap()
        
        // Submit order
        SecondPage.orderSubmitButton().tap()
        
        // Assert the CG has been changed
        waitForElementToAppear(element: FirstPage.redCGNoText(), timeout: 10)
        
        // Delete the red CG
        FirstPage.redCGNoText().press(forDuration: 0, thenDragTo: FirstPage.ToolBox())
        app.buttons["Delete"].tap()

    }
    
    func testCaseC359(){
        
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // If time confirmation alert is displayed, click "Confirm"
        sleep(10)
        if timeConfirmationAlert.exists{
            LoginPage.ifTimeConfirmationAlertIsDisplay()
        }
        else{
            waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        }
        
        // Choose table
        FirstPage.chooseTables(tableID: "T", tableNum: 1).doubleTap()
        
        // Choose order
        SecondPage.randomOrderItemsFromMenu(orderNum: 1)
        
        // Add people
        SecondPage.addPeopleButton().tap()
        
        // Submit order
        SecondPage.orderSubmitButton().tap()

        // Assert yellow CG has been created.
        XCTAssertEqual(FirstPage.yellowCGText().exists, true, "The CG has been created and submitted.")
        
        // Delete the yellow CG
        FirstPage.yellowCGText().press(forDuration: 0, thenDragTo: FirstPage.ToolBox())
        
        // Waiting for dialogue displayed.
        waitForElementToAppear(element: app.staticTexts["Confirm delete"], timeout: 10)
        XCTAssertEqual(app.staticTexts["Confirm delete"].label
, "Confirm delete", "The pop up message is not show [Confirm delete].")
       
        // Click cancel button
        app.buttons["Cancel"].tap()
        
        // Delete the yellow CG again
        FirstPage.yellowCGText().press(forDuration: 0, thenDragTo: FirstPage.ToolBox())
        
        // Click Delete button
        app.buttons["Delete"].tap()
        
        // Assert the CG is delete.
        XCTAssertEqual(FirstPage.yellowCGText().exists, false, "The yellow CG does not be deleted.")
    }
    
    /* 半結無法離店 */
    func testCaseC360(){
    
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // If time confirmation alert is displayed, click "Confirm"
        sleep(10)
        if timeConfirmationAlert.exists{
            LoginPage.ifTimeConfirmationAlertIsDisplay()
        }
        else{
            waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        }
        
        // Choose table
        FirstPage.chooseTables(tableID: "T", tableNum: 1).doubleTap()
        
        // Choose order
        SecondPage.randomOrderItemsFromMenu(orderNum: 1)
        
        // Add people
        SecondPage.addPeopleButton().tap()

        // Tap checkout button then go to page 3
        SecondPage.checkOutButton().tap()
        
        // Spilt the order
        ThirdPage.addSplitCheckButton().tap()
        
        // Click payment button
        ThirdPage.enterPaymentButton().tap()
        
        // Checkout the first order
        FourthPage.swipeCheckBar()
        waitForElementToAppear(element: FourthPage.waitCheckOutSuccessPopUp(), timeout: 10)
        FourthPage.tapCheckOutSuccessPopUp().tap()
        
        // Go back to First page
        FourthPage.goBackButton().tap()
        ThirdPage.goBackButton().tap()
        SecondPage.gobackButton().tap()
        
        // Delete the yellow CG
        FirstPage.yellowCGText().press(forDuration: 0, thenDragTo: FirstPage.ToolBox())
        
        // Delete yellow CG, but should be cancel
        waitForElementToAppear(element: FirstPage.confirmCGDeprtureText(), timeout: 10)
        FirstPage.confirmCGDeprturCancelButton().tap()
        
        // Click yellow CG again
        FirstPage.yellowCGText().doubleTap()
        
        // Tap checkout button then go to page 3
        SecondPage.checkOutButton().tap()

        // Click payment button
        ThirdPage.enterPaymentButton().tap()
        
        // Checkout the one of spilted order
        FourthPage.swipeCheckBar()
        waitForElementToAppear(element: FourthPage.waitCheckOutSuccessPopUp(), timeout: 10)
        FourthPage.tapCheckOutSuccessPopUp().tap()
        
        // Assert the yellow CG has out.
        XCTAssertEqual(FirstPage.yellowCGText().exists, false, "The yellow CG still stand here.")
        
    }
    
    func testCaseC361(){

    }
    
    /* Page4 - 信用卡支付結帳成功 */
    func testCaseC362(){
    
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // If time confirmation alert is displayed, click "Confirm"
        sleep(10)
        if timeConfirmationAlert.exists{
            LoginPage.ifTimeConfirmationAlertIsDisplay()
        }
        else{
            waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        }
        
        // Choose table
        FirstPage.chooseTables(tableID: "T", tableNum: 1).doubleTap()
        
        // Choose order
        SecondPage.randomOrderItemsFromMenu(orderNum: 1)
        
        // Add people
        SecondPage.addPeopleButton().tap()
        
        // Tap checkout button then go to page 3
        SecondPage.checkOutButton().tap()
        
        // Click payment button then go to page 4
        ThirdPage.enterPaymentButton().tap()
        
        // paymentMethod = cash, card, mpos twinvoice
        FourthPage.selectPaymentMethod(paymentMethod: "Card").tap()
        
        // Select Credit Card type
        FourthPage.selectMaster().tap()
        
        // Enter last 4 Digits
        FourthPage.enterLast4Digits(digits: "9478")
        FourthPage.KBKeyHide().tap()
        sleep(2)
        
        // Enter payment note
        FourthPage.enterCardPaymentNotes()
        
        // Checkout
        FourthPage.swipeCheckBar()
        waitForElementToAppear(element: FourthPage.waitCheckOutSuccessPopUp(), timeout: 10)
        FourthPage.tapCheckOutSuccessPopUp().tap()
        XCTAssertEqual(FirstPage.redCGNoText().exists, false, "The yellow CG still stand here.")
    }
    
    /* 工具箱 - 設定印表機  */
    func testCaseC365(){
    
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // If time confirmation alert is displayed, click "Confirm"
        sleep(10)
        if timeConfirmationAlert.exists{
            LoginPage.ifTimeConfirmationAlertIsDisplay()
        }
        else{
            waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        }
        
        // Tap toolbox
        FirstPage.ToolBox().tap()
        
        // Click printer setting
        FirstPage.printerSettingWithinTooBox().tap()
        
        // Chooise printer and then release printer
        FirstPage.printerActionSetingAndNotSetting()
    }
    
    /* Server 並以離線模式登入成功 */
    func testCaseC425(){
    
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        
        // offline login
        LoginPage.offlineLoginButton().tap()
        
        // Tap tool box
        FirstPage.ToolBox().tap()
        
        // Tap system information box
        FirstPage.systemInfoWithinTooBox().tap()
        
        // Assert the login mmode is [Offline Login]
        let loginModeInSysInfo = app.tables.staticTexts["Server iPad(Offline Login)"].label
        XCTAssertEqual(loginModeInSysInfo, "Server iPad(Offline Login)", "Login mode has got problem.")
        
        // Click X back to tables
        app.buttons["TC CloseTCPopover BTN"].tap()
    }
    
    /* 權限 - 以 錢櫃管理] 功能代表驗證權限與功能正常 */
    func testCaseC889(){
    
        // Login app
        LoginPage.inputAppLoginInfo(storeid: smokeTestRestaurantID, userid: smokeTestUserID, password: smokeTestPassword)
        LoginPage.tapLoginButton().tap()
        // offline login
        LoginPage.offlineLoginButton().tap()
        
        // Tap tool box
        FirstPage.ToolBox().tap()
        
        // Click Cash Drawer
        FirstPage.cashDrawerWithinTooBox().tap()
        
        // Click open case drawer
        FirstPage.openCaseDrawer().tap()
        
        // Enter auth password and verify who open it.
        FirstPage.verifyUserNameAfterTapAuthPassword(user: "admin", authPwd: "0000")
    }
}




