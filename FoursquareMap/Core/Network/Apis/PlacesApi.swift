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

    var requestType: BaseRequest.Type {
    switch self {
    case .foursquare:
        return FourSquareRequest.self
        /**
         TO DO ......
         Add sources as wanted .googlePlaces, .herePlaces ...... etc
         */
        }
    }
    
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
