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
    var completionHandler: (([Place])->Void)? { get set }
    var errorHandler: ((NetworkError)->Void)? { get set }
    var dataProvider:DataProvider { get }
    func fetchPlaces(coordinate:CLLocationCoordinate2D)
}

class FoursquarePlaceInteractor: PlaceInteractorProtocol {
    
    var completionHandler: (([Place])->Void)?
    var errorHandler: ((NetworkError)->Void)?
    internal var dataProvider:DataProvider
    
    init(dataProvider:DataProvider) {
        self.dataProvider = dataProvider
    }
    
    func fetchPlaces(coordinate:CLLocationCoordinate2D) {
        let request = FourSquareRequest.searchLocationRequest(lat: coordinate.latitude, lng: coordinate.longitude, query: "restaurants")
        dataProvider.perfromRequest(request: request, of: FoursquareSearchResponse.self, completion: { (response) in
            if let searchResponse = response {
                if searchResponse.isSuccess {
                    self.completionHandler?(searchResponse.data)
                } else {
                    self.errorHandler?(.other)
                }
            } else {
                self.errorHandler?(.other)
            }
        }) { (error) in
            self.errorHandler?(error)
        }
    }
    
    func loadPlaceDetails(placeId:String) {
        let request = FourSquareRequest(path: .details, paramters: ["id":placeId])
        dataProvider.perfromRequest(request: request, of: FoursquareDetailsResponse.self, completion: { (response) in
            if let searchResponse = response {
                if searchResponse.isSuccess {
                    self.completionHandler?(searchResponse.data)
                } else {
                    self.errorHandler?(.other)
                }
            } else {
                self.errorHandler?(.other)
            }
        }) { (error) in
            self.errorHandler?(error)
        }
    }
}
