//
//  FourSquareResponseModelTest.swift
//  FoursquareMapTests
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import XCTest
import MapKit

class MapViewPresenterTests: XCTestCase {

    var presenter:MapViewPresenter?
    var view = MapViewMock()
    
    override func setUp() {
        let dataProvider = NetworkMockingManager(bundle: Bundle(for: type(of: self)))
        presenter = MapViewPresenter(dataProvider: dataProvider)
        presenter?.delegate = view
    }

    func testLoadPlaces() {
        presenter?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let data = presenter?.model
        XCTAssertNotNil(data)
    }

    func testGetAnnotations() {
        presenter?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let annotations = view.mockedAnnotations
        XCTAssertNotNil(annotations)
        XCTAssertGreaterThan(annotations?.count ?? 0, 0)
    }
    
    func testErrorGeneration() {
        let dataProvider = NetworkMockingManager(bundle: Bundle(for: type(of: self)))
        dataProvider.showError = true
        
        let mapView = MapViewMock()
        
        let mapPresenter = MapViewPresenter(dataProvider: dataProvider)
        mapPresenter.delegate = mapView
        mapPresenter.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        let error = mapView.mockedError
        XCTAssertNotNil(error)
    }
    
    func testGetAnnotationsPerformance() {
        self.measure {
            presenter?.loadPlaces(coordinate: CLLocationCoordinate2D(latitude: 0, longitude: 0))
        }
    }
}
