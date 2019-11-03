//
//  FoursquarePlaceInteractor.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

protocol PlaceInteractorProtocol {
    var completionHandler: ([Place])->Void { get }
    var errorHandler: (NetworkError)->Void { get }
    var dataProvider:DataProvider { get }
    func fetchPlaces(coordinate:CLLocationCoordinate2D)
}

class FoursquarePlaceInteractor: PlaceInteractorProtocol {
    
    var completionHandler: ([Place])->Void
    var errorHandler: (NetworkError)->Void
    internal var dataProvider:DataProvider
    
    init(dataProvider:DataProvider, onSuccess:@escaping ([Place])->Void, onFailure:@escaping (NetworkError)->Void) {
        self.completionHandler = onSuccess
        self.errorHandler = onFailure
        self.dataProvider = dataProvider
    }
    
    func fetchPlaces(coordinate:CLLocationCoordinate2D) {
        
        let request = FourSquareRequest.searchLocationRequest(lat: coordinate.latitude, lng: coordinate.longitude, query: "restaurants")
        dataProvider.perfromRequest(request: request, of: FoursquareResponse.self, completion: { (response) in
            if let searchResponse = response {
                if searchResponse.isSuccess {
                    self.completionHandler(searchResponse.data)
                } else {
                    self.errorHandler(.other)
                }
            } else {
                self.errorHandler(.other)
            }
        }) { (error) in
            self.errorHandler(error)
        }
    }
}
