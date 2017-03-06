//
//  PageOneObjectClass.swift
//  iCHEF
//
//  Created by EdwardChen on 12/29/16.
//  Copyright © 2016 iCHEF. All rights reserved.
//
// LoginPageObjects which is include first login page and progress ber page.

import Foundation
import XCTest

let app = XCUIApplication()

class LoginPage: XCTestCase {
    
    public class func inputAppLoginInfo(storeid: String, userid: String, password: String){

        let storeIdTextField = app.textFields["Store ID"]
        
        //若要測試的 StoreID 與上次登入的 StoreID 相同就不用再輸入一次
        
        let existStioreID = storeIdTextField.value as! String
        if existStioreID != storeid{
            
            storeIdTextField.doubleTap()
            sleep(1)
            
            //判斷 StoreID 為空（app第一次登入）就直接輸入 storeid，不然就以 Select All 複寫
            if app.menuItems["Select All"].exists{
                app.menuItems["Select All"].tap()
            }
            storeIdTextField.typeText(storeid)
            
            let userIdTextField = app.textFields["User ID"]
            userIdTextField.doubleTap()
            
            sleep(1)
            
            if app.menuItems["Select All"].exists{
                app.menuItems["Select All"].tap()
            }
            userIdTextField.typeText(userid)
        }
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("admin")
        
    }
    
    public class func tapLoginButton() -> XCUIElement{
        
        app.images["LoginView-iCHEFLogo"].tap()
        let element = app.buttons["loginButton"]
        return element
    }
    
    public class func otherLoginOption() -> XCUIElement{
        
        let element = app.buttons["Other login option"]
        return element
    
    }
    
    public class func loginAfterReDownloadConfig() -> XCUIElement{
        
        let element = app.buttons["Login after re-download config >"]
        return element
    }
    
    public class func dragUpSystemStatus(){
    
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.swipeRight()
        
    }
    
    public class func dragDownSystemStatus(){
        
        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element(boundBy: 1).children(matching: .other).element.children(matching: .image).element(boundBy: 0).swipeDown()
        
    }
    
    public class func tapCancelLoginButton() -> XCUIElement{
        
        let element = app.buttons["Cancel login"]
        return element
    }
    
    public class func offlineLoginButton() -> XCUIElement{
    
        let element = app.buttons["Offline login"]
        return element
    }
    
    public class func ifTimeConfirmationAlertIsDisplay(){
    
        let timeConfirmationAlert = XCUIApplication().alerts["Time Confirmation"]
        if timeConfirmationAlert.exists{
            
            timeConfirmationAlert.buttons["Confirm"].tap()
//            timeConfirmationAlert.staticTexts["Time Confirmation"].tap()
//            timeConfirmationAlert.buttons["Cancel"].tap()
        }
    
    }
    
}
