//
//  SixtRequestTest.swift
//  SixtCarsTests
//
//  Created by Mohamed Hassan on 10/6/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class SixtRequestTest: XCTestCase {

    var request:SixtRequest?
    
    override func setUp() {
        request = SixtRequest(paramters: nil)
    }

    func testRequestCreation() {
        XCTAssertNotNil(request)
    }
    
    func testRequestHasUrl() {
        XCTAssertNotNil(request?.url)
    }
    
    func testRequestHasApiKey() {
        request = SixtRequest(paramters: ["key":"value"])
        XCTAssertNotNil(request?.paramters?["key"])
    }
    
    func testRequestIsHttpGet() {
        XCTAssertEqual(request?.method, .get)
    }

}
