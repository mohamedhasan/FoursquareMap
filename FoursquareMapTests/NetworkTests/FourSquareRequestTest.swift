//
//  FourSquareRequestTest.swift
//  FourSquareRequestTest
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class FourSquareRequestTest: XCTestCase {

    var request:FourSquareRequest?
    
    override func setUp() {
        request = FourSquareRequest.searchLocationRequest(lat: 33.33, lng: 22.22, query: "query")
    }

    func testRequestCreation() {
        XCTAssertNotNil(request)
    }
    
    func testRequestHasUrl() {
        XCTAssertNotNil(request?.requestUrl())
    }
    
    func testRequestHasProperAuth() {
        XCTAssertNotNil(request?.paramters?["client_id"])
        XCTAssertNotNil(request?.paramters?["client_secret"])
        XCTAssertNotNil(request?.paramters?["v"])
    }
    
    func testRequestLatLongCreated() {
        XCTAssertNotNil(request?.paramters?["ll"])
    }
    
    func testRequestLatLongCorrect() {
        XCTAssertEqual(request?.paramters?["ll"] as? String, "33.33,22.22")
    }
    
    func testRequestContentType() {
        XCTAssertEqual(request?.headers?["Content-Type"], "application/json")
    }
    
    func testSearchRequestIsHttpGet() {
        XCTAssertEqual(request?.path.method, .get)
    }

}
