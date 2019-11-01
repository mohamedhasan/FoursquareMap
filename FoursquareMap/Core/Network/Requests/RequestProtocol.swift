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
}

protocol RequestProtocol:NSObject {
    var baseURL : String { get }
    var headers : [String:String]? { get }
    var paramters : [String:Any]? { get }
    var path:RequestPathProtocol? { get }
}

class BaseRequest:NSObject,RequestProtocol {
    var baseURL:String
    var headers: [String : String]?
    var paramters: [String : Any]?
    var path: RequestPathProtocol?
    
    init(path:FourSquareRequestPath,paramters:[String:Any]?) {
        self.baseURL = ""
        self.path = path
        self.paramters = paramters
    }

}
