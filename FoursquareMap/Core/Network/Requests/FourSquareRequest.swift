//
//  FourSquareRequest.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import Alamofire

enum FourSquareRequestPath:RequestPathProtocol {
    case search
    case details
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        case .details:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "venues/search"
        case .details:
            return "venues"
        }
    }
    
    var mockName: String {
        switch self {
        case .search:
            return "foursquareResponse"
        case .details:
            return "placeModel"
        }
    }
}

class FourSquareRequest: BaseRequest {
    
    private static let CLIENT_ID = "GFJMKSTN5BXTDX2BC5NWK5N3QRSEGXC3BMDETUHRYDPVRE4B"
    private static let CLIENT_SECRET = "LHEKUSAN0SHJTIVRDY45WNYNUQY1CGPPO3OGYNVSSFDR1YDQ"
    private static let API_VERSION = "20180323"
    
    required init(path:FourSquareRequestPath,paramters:[String:Any]?) {
        super.init(path: path, paramters: paramters)
        
        let authParams:[String:Any] = ["client_id":FourSquareRequest.CLIENT_ID,
                                       "client_secret":FourSquareRequest.CLIENT_SECRET,
                                       "v":FourSquareRequest.API_VERSION]
        let allParamters = authParams.merging(paramters ?? [:]) { (key, value) -> Any in
            return value
        }
        self.baseURL = "https://api.foursquare.com/v2"
        self.headers = ["Content-Type" : "application/json"]
        self.paramters = allParamters
        self.path = path
    }

    class func searchLocationRequest(lat:Double,lng:Double,query:String) -> FourSquareRequest {
        let latLng = "\(lat),\(lng)"
        return FourSquareRequest(path: .search, paramters: ["ll":latLng,"query":query])
    }

    override func requestUrl() -> String! {
        var url = super.requestUrl()
        let requestPath = self.path as! FourSquareRequestPath
        if requestPath == .details {
            if let id = paramters?["id"] as? String {
                url = url! + "/" + id
            }
        }
        return url
    }
}
