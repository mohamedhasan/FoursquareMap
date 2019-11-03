//
//  RequestProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import Alamofire

protocol RequestPathProtocol {
    var path: String { get }
    var method : HTTPMethod { get }
    var mockName: String { get }
}

protocol RequestProtocol:NSObject {
    var baseURL : String { get }
    var headers : [String:String]? { get }
    var paramters : [String:Any]? { get }
    var path:RequestPathProtocol { get }
    
    init(path:FourSquareRequestPath,paramters:[String:Any]?)
    func requestUrl() -> String!
}

class BaseRequest:NSObject,RequestProtocol {
    internal var baseURL:String
    var headers: [String : String]?
    var paramters: [String : Any]?
    var path: RequestPathProtocol
    
    required init(path:FourSquareRequestPath,paramters:[String:Any]?) {
        self.baseURL = ""
        self.path = path
        self.paramters = paramters
    }

    func requestUrl() -> String! {
        return "\(baseURL)/\(path.path)"
    }
}
