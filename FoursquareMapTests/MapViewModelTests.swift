//
//  FourSquareResponseModelTest.swift
//  FoursquareMapTests
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest
import MapKit

class MapViewModelTests: XCTestCase {

    var viewModel:MapViewModel?
    
    override func setUp() {
        let dataProvider = NetworkMockingManager(bundle: Bundle(for: type(of: self)))
        viewModel = MapViewModel(dataProvider: dataProvider)
    }

    func testLoadPlaces() {
        viewModel?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let data = viewModel?.model
        XCTAssertNotNil(data)
    }

    func testGetAnnotations() {
        viewModel?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let annotations = viewModel?.getAnnotations()
        XCTAssertNotNil(annotations)
        XCTAssertGreaterThan(annotations?.count ?? 0, 0)
    }
    
    func testGetAnnotationsPerformance() {
        self.measure {
            viewModel?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        }
    }
}
