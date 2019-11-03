//
//  FourSquareModelTest.swift
//  FoursquareMapTests
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest

class FourSquareModelTest: XCTestCase {

    var modelMock:FoursquarePlace?
    override func setUp() {
        if let path = Bundle(for: type(of: self)).path(forResource: "foursquarePlace", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                guard let json = try? JSONSerialization.jsonObject(with: data, options:[]) else {
                    assert(false)
                }
                modelMock = try JsonParser.parseResponse(json: json, type: FoursquarePlace.self)
            }
            catch {
                assert(false)
            }
        }
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testHasTitle() {
        XCTAssertNotNil(modelMock?.title)
    }

    func testHasAddress() {
        XCTAssertNotNil(modelMock?.address)
    }
    
    func testHasLong() {
        XCTAssertNotNil(modelMock?.lng)
    }
    
    func testHasLat() {
        XCTAssertNotNil(modelMock?.lat)
    }

}
