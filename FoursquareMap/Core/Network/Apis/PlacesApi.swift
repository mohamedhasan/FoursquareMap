//
//  PlacesApi.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

enum PlacesSource {

    case foursquare

    /**
    TO DO ......
    Add Generic request creations for multiple Sources : googlePlaces, herePlaces ...... etc
    */
//    var requestType: BaseRequest.Type {
//    switch self {
//    case .foursquare:
//        return FourSquareRequest.self
//        }
//    }
    
}
    
class PlacesApi: NSObject {

    static let shared:PlacesApi = PlacesApi()
    
    
    func searchPlaces(source:PlacesSource,lat:Double,lng:Double, completion: @escaping (ResponseProtocol?) -> Void, errorHandler:@escaping (NetworkError) -> Void) {
        
        switch source {
        case .foursquare:
            let request = FourSquareRequest.searchLocationRequest(lat: lat, lng: lng, query: "restaurants")
            NetworkManager.sharedInstance.perfromRequest(request: request, of: FoursquareResponse.self, completion: completion, errorHandler: errorHandler)
            break
        }
           
    }
    
    
}
