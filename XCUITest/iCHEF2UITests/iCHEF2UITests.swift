//
//  iCHEF2UITests.swift
//  iCHEF2UITests
//
//  Created by EdwardChen on 11/7/16.
//  Copyright © 2016 iCHEF. All rights reserved.
//

import XCTest

class iCHEF2UITests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        XCUIApplication().launch()
        
    }
    
    override func tearDown() {
    
        super.tearDown()
    }
    
    func testCheckOutFirstCG() {
        

        LoginPage.inputAppLoginInfo(storeid: "twautotest001", userid: "admin", password: "admin")
        LoginPage.tapLoginButton().tap()
        
        waitForElementToAppear(element: app.staticTexts["iCHEF Server"], timeout: 20)
        
        FirstPage.chooseTables(tableID: "B", tableNum: 3).doubleTap()
        
        SecondPage.randomOrderItemsFromMenu(orderNum: 3)
        SecondPage.addPeopleButton().tap()
        
        let totalPrice: String = SecondPage.getTotalPrice()
        SecondPage.checkOutButton().tap() // Go to Page 3
        
        let totalUnpaidPrice: String = ThirdPage.getTotalUnpaidPrice()
        XCTAssertEqual(totalPrice, totalUnpaidPrice, "Total price of 2nd page is different with Unpaid price of 3rd page.")
        
        ThirdPage.enterPaymentButton().tap() // Go to Page 4
        
        FourthPage.swipeCheckBar()
        waitForElementToAppear(element: FourthPage.waitCheckOutSuccessPopUp())
        
        FourthPage.tapCheckOutSuccessPopUp().tap()
    }

}
