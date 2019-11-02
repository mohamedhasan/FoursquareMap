//
//  FourSquareResponseModelTest.swift
//  FoursquareMapTests
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class FourSquareResponseModelTest: XCTestCase {

    var responseMock:FoursquareResponse?
    override func setUp() {
        if let path = Bundle(for: type(of: self)).path(forResource: "foursquareResponse", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                responseMock = try decoder.decode(FoursquareResponse.self, from: data)
            }
            catch {
                assert(false)
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIsSuccess() {
        XCTAssert(responseMock?.isSuccess ?? false)
    }
    
    func testHasPlaces() {
        XCTAssertGreaterThan(responseMock?.data.count ?? 0 ,0)
    }

    func testHasAddress() {
        XCTAssertNil(responseMock?.error)
    }

}
