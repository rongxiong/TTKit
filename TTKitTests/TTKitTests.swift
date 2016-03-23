//
//  TTKitTests.swift
//  TTKitTests
//
//  Created by 陈荣雄 on 3/23/16.
//  Copyright © 2016 陈荣雄. All rights reserved.
//

import XCTest
@testable import TTKit

class TTKitTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let base64String = "iambase64".base64EncodedString()
        XCTAssertNotNil(base64String, "base64 encode is Failed")
        let rawString = base64String?.base64RawString()
        XCTAssertEqual(rawString, "iambase64", "base64 decode is Failed")
        let encodeURLString = "https://www.google.com/test?name=陈荣雄".escape()
        XCTAssertNotNil(encodeURLString, "escape encode is Failed")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
