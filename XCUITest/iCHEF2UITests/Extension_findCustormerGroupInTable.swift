//
//  Extension_findCustormerGroupInTable.swift
//  iCHEF
//
//  Created by TrevorLee on 2017/1/13.
//  Copyright © 2017年 iCHEF. All rights reserved.
//

import Foundation
import XCTest


extension XCUIElementQuery:Sequence{
    
    public func makeIteratorForCatchItem(_ numberOfItem: UInt) -> AnyIterator<XCUIElement> {
        var curren2Index: UInt = 0
        return AnyIterator{
            if curren2Index >= numberOfItem {
                return nil
            }else{
                let element = self.element(boundBy: curren2Index)
                curren2Index += 1
                return element
            }
        }
    }
   
    public func makeIterator() -> AnyIterator<XCUIElement> {
        var currenIndex:UInt = 0
        return AnyIterator{
            if currenIndex >= self.count{
                return nil
            }else{
                let element = self.element(boundBy: currenIndex)
                currenIndex += 1
                return element
            }
        }
    }
}

//目前只能刪沒有半結的 紅、黃、綠 單
public func deletAllCustomerGroupFromTables(fromTable table:String){
    let filteCustormerGroupInElment = NSPredicate(format: "(label contains '\(table), ')", argumentArray: nil)
    let queryCustormerGroup = app.otherElements.matching(filteCustormerGroupInElment)
    for _ in Array(queryCustormerGroup){
        Array(queryCustormerGroup).first?.press(forDuration: 0, thenDragTo: app.buttons["toolBoxButton"])
        app.buttons["Delete"].tap()
    }
}

//依序點擊數個Item，排序為 GridMenu 由上至下、由左至右，若為空格則掠過該空格抓取下一格品項
//來源為：app.collectionViews["orderMenuCollectionView"].cells["displayMenuCell_0_0_0_1_0"]，抓取 displayMenuCell_0_0_0_Ｎ_0 的品項
public func additem(numberOfItem:UInt){
    let filter = NSPredicate(format: "(label contains 'displayMenuCell')", argumentArray: nil)
    let find = app.collectionViews["orderMenuCollectionView"].cells.matching(filter)
    for element:XCUIElement in find.makeIteratorForCatchItem(numberOfItem) {
        element.tap()
    }
}



