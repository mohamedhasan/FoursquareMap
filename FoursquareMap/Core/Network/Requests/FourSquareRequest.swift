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
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .search:
            return "/venues/search"
        }
    }
}

class FourSquareRequest: BaseRequest {
    
    
    override init(path:FourSquareRequestPath,paramters:[String:Any]?) {
        
        super.init(path: path, paramters: paramters)
        self.baseURL = "https://api.foursquare.com/v2"
        self.headers = ["Content-Type" : "application/json"]
        self.path = path
        self.paramters = paramters
    }

}
