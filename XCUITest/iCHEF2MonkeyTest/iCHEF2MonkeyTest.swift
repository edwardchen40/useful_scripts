//
//  iCHEF2MonkeyTest.swift
//  iCHEF2MonkeyTest
//
//  Created by EdwardChen on 11/22/16.
//  Copyright © 2016 iCHEF. All rights reserved.
//

import XCTest

class iCHEF2MonkeyTest: XCTestCase {
    
    let minimumGestureFrequency: UInt32 = 1 // Minimum amount of time to pass between gestures in seconds
    let duration: Double = 60 * 120 // Execution time limit in seconds (default 60 * 120)
    let gestureLimit: UInt = 100 // Number of gestures to be executed (default 100)
    let gestureTypeCount: UInt32 = 12 // Number of types of gesture available
    let app = XCUIApplication()
        
    override func setUp() {
        super.setUp()
        // In these chaos tests, why not continue after failure, if nothing's crashed? CHAOS!
        continueAfterFailure = true
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        
        // To take a snapshot
        setupSnapshot(app: app)
        app.launch()
        
        let passwordSecureTextField = app.secureTextFields["Password"]
        passwordSecureTextField.tap()
        passwordSecureTextField.typeText("admin")
        snapshot(name: "Enter password")
        app.images["LoginView-iCHEFLogo"].tap()
        app.buttons["loginButton"].tap()
        
        
        waitForElementToAppear(element: app.buttons["B4_addButton"], timeout: 20)
        snapshot(name: "Login successful")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testMonkeyHandlingForDuration() {
        // Create a loop for the given time limit
        let end = NSDate(timeIntervalSinceNow: duration)
        while NSDate().compare(end as Date) == ComparisonResult.orderedAscending {
            // Execute a gesture based on the random number
            executeRandomGesture()
        }
    }
    
    func testMonkeyHandlingUntilGestureLimit() {
        // Loop for as many times as the gesture limit allows
        for _ in 0..<gestureLimit {
            executeRandomGesture()
        }
    }
    
    
    private func executeRandomGesture() {
        let randomGestureID = arc4random_uniform(gestureTypeCount)
        let coordinate = getRandomCoordinate()
        let device = XCUIDevice.shared()
        switch randomGestureID {
        case 0:
            coordinate.tap()
            snapshot(name: "Tap location on \(coordinate)")
            print("Memory (MB) =", getMegabytesUsed())
        case 1:
            coordinate.doubleTap()
            snapshot(name: "Double tap location on \(coordinate)")
            print("Memory (MB) =", getMegabytesUsed())
        case 2:
            // Scroll up
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startY = coordinate.screenPoint.y
            let dy = (startY * getRandomValueBetween0And1()) / maxSize.height
            let vector = CGVector(dx: coordinate.screenPoint.x / maxSize.width, dy: dy)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
            snapshot(name: "Scroll up from \(coordinate) to \(vector)")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 3:
            // Scroll down
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startY = coordinate.screenPoint.y
            let dy = ((maxSize.height - startY) * getRandomValueBetween0And1() + startY) / maxSize.height
            let vector = CGVector(dx: coordinate.screenPoint.x / maxSize.width, dy: dy)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
            snapshot(name: "Scroll down from \(coordinate) to \(vector)")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 4:
            // Scroll left
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startX = coordinate.screenPoint.x
            let dx = (startX * getRandomValueBetween0And1()) / maxSize.width
            let vector = CGVector(dx: dx, dy: coordinate.screenPoint.y / maxSize.height)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
            snapshot(name: "Scroll left from \(coordinate) to \(vector)")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 5:
            // Scroll right
            let maxSize = app.windows.element(boundBy: 0).frame.size
            let startX = coordinate.screenPoint.x
            let dx = ((maxSize.width - startX) * getRandomValueBetween0And1() + startX) / maxSize.width
            let vector = CGVector(dx: dx, dy: coordinate.screenPoint.y / maxSize.height)
            scroll(fromCoordinate: coordinate, toCoordinate: getCoordinateForVector(vector: vector))
            snapshot(name: "Scroll right from \(coordinate) to \(vector)")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 6:
            device.orientation = .portrait
            snapshot(name: "Orientation -> Portrait")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 7:
            device.orientation = .portraitUpsideDown
            snapshot(name: "Orientation -> PortraitUpsideDown")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 8:
            device.orientation = .landscapeLeft
            snapshot(name: "Orientation -> LandscapeLeft")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 9:
            device.orientation = .landscapeRight
            snapshot(name: "Orientation -> LandscapeRight")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
      //  case 10:
      //      device.orientation = .faceUp
      //  case 11:
      //      device.orientation = .faceDown
        case 10:
            // Move in a completely random direction
            scroll(fromCoordinate: coordinate, toCoordinate: getRandomCoordinate())
            snapshot(name: "Scroll random direction")
            coordinate.tap()
            print("Memory (MB) =", getMegabytesUsed())
        case 11:
            coordinate.press(forDuration: 2)
            print("Memory (MB) =", getMegabytesUsed())
        default:
            XCTFail("Random number failure - unhandled case for number: \(randomGestureID)")
            print("Memory (MB) =", getMegabytesUsed())
        }
        print("Executed gesture \(randomGestureID) on coordinate: \(coordinate)")
        
        // Wait for cooldown period
        sleep(minimumGestureFrequency)
        print("Memory (MB) =", getMegabytesUsed())
    }
    
    private func getRandomCoordinate() -> XCUICoordinate {
        let randomX = getRandomValueBetween0And1()
        let randomY = getRandomValueBetween0And1()
        
        let randomVector = CGVector(dx: randomX, dy: randomY)
        let coordinate = getCoordinateForVector(vector: randomVector)
        
        return coordinate
    }
    
    private func getCoordinateForVector(vector: CGVector) -> XCUICoordinate {
        let window = app.windows.element(boundBy: 0)
        let coordinate = window.coordinate(withNormalizedOffset: vector)
        return coordinate
    }
    
    private func getRandomValueBetween0And1() -> CGFloat {
        return CGFloat(Float(arc4random()) / Float(UINT32_MAX))
    }
    
    private func scroll(fromCoordinate: XCUICoordinate, toCoordinate: XCUICoordinate) {
        fromCoordinate.press(forDuration: 0, thenDragTo: toCoordinate)
    }
    
    func waitForElementToAppear(element: XCUIElement, timeout: TimeInterval = 5,  file: String = #file, line: UInt = #line) {
        let existsPredicate = NSPredicate(format: "exists == true")
        
        expectation(for: existsPredicate, evaluatedWith: element, handler: nil)
        
        waitForExpectations(timeout: timeout) { (error) -> Void in
            if (error != nil) {
                let message = "Failed to find \(element) after \(timeout) seconds."
                self.recordFailure(withDescription: message, inFile: file, atLine: line, expected: true)
            }
        }
    }
    
    // Get Memory Usage (How many memory was used by MB)
    func mach_task_self() -> task_t {
        return mach_task_self_
    }
    
    func getMegabytesUsed() -> Float? {
        var info = mach_task_basic_info()
        var count = mach_msg_type_number_t(MemoryLayout.size(ofValue: info) / MemoryLayout<integer_t>.size)
        let kerr = withUnsafeMutablePointer(to: &info) { infoPtr in
            return infoPtr.withMemoryRebound(to: integer_t.self, capacity: Int(count)) { (machPtr: UnsafeMutablePointer<integer_t>) in
                return task_info(
                    mach_task_self(),
                    task_flavor_t(MACH_TASK_BASIC_INFO),
                    machPtr,
                    &count
                )
            }
        }
        guard kerr == KERN_SUCCESS else {
            return nil
        }
        return Float(info.resident_size) / (1024 * 1024)
    }
    
}
