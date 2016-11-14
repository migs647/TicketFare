//
//  FareDataModelTests.swift
//  TicketFareTests
//
//  Created by Cody Garvin on 11/13/16.
//  Copyright © 2016 Cody Garvin. All rights reserved.
//

import XCTest
@testable import TicketFare

class FareDataModelTests: XCTestCase {

    var dataModels: [FareDataModel]? = nil
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        dataModels = FareDataModel.fetchFareData()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testFormattedName() {
        
        if let dataModel = dataModels?[0] {
            let attributes =
                dataModel.formattedName().attributes(at: 0,
                                                     longestEffectiveRange: nil,
                                                     in: NSMakeRange(0, dataModel.formattedName().length))

            for (attribute, value) in attributes {
                
                XCTAssert(attribute == NSForegroundColorAttributeName ||
                    attribute == NSFontAttributeName, "Attributes are incorrect for the attributed name")
                
                if attribute == NSForegroundColorAttributeName {
                    if let value = value as? UIColor {
                        XCTAssert(value == UIColor.gray, "Color should be gray")
                    }
                } else if attribute == NSFontAttributeName {
                    if let value = value as? UIFont {
                        XCTAssert(value == UIFont.boldSystemFont(ofSize: 16.0), "Font should be bold, system 16.0")
                    }
                    
                }
            }
        }
    }
    
    func testFormattedDescriptionWithValidData() {
        
        if let dataModel = dataModels?[1] {
            
            guard let description = dataModel.formattedDescription() else { return }
            let attributes =
                description.attributes(at: 0,
                                       longestEffectiveRange: nil,
                                       in: NSMakeRange(0, description.length))
            
            for (attribute, value) in attributes {
                
                XCTAssert(attribute == NSForegroundColorAttributeName ||
                    attribute == NSFontAttributeName, "Attributes are incorrect for the attributed name")
                
                if attribute == NSForegroundColorAttributeName {
                    if let value = value as? UIColor {
                        XCTAssert(value == UIColor.gray, "Color should be gray")
                    }
                } else if attribute == NSFontAttributeName {
                    if let value = value as? UIFont {
                        XCTAssert(value == UIFont.systemFont(ofSize: 14.0), "Font should be normal, system 16.0")
                    }
                    
                }
            }
        }
    }
    
    func testFormattedDescriptionWithNilData() {
        
        if let dataModel = dataModels?[0] {
            
            guard let _ = dataModel.formattedDescription() else { return }
            XCTFail("There should not be any formatted strings for this object")
        }
    }


    func testSort() {
        
    }
}
