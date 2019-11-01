//
//  NetworkManager.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import Alamofire

class NetworkManager: NSObject {

    static let sharedInstance = NetworkManager()
    
    var connectedToInternet: Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func perfromRequest <T:Codable>(request:RequestProtocol, of type: T.Type, completion: @escaping (T?) -> Void,errorHandler: @escaping (NetworkError) -> Void) {
        
        if !connectedToInternet {
            print("Not Connected To Internet")
            errorHandler(NetworkError.noInternetConnection)
            return
        }
        
        guard let url = URL(string: request.requestUrl()) else {
            return
        }
        let headers = request.headers
        let paramters = request.paramters
        let httpMethod = request.path.method
        let encoding = (httpMethod == .get) ? URLEncoding(destination: .queryString) as ParameterEncoding : JSONEncoding.prettyPrinted as ParameterEncoding
        
        Alamofire.request(url
            , method: httpMethod
            , parameters: paramters
            , encoding: encoding
            , headers: headers).validate().responseJSON { (response) -> Void in
                
                guard response.result.isSuccess else {
                    let errorMessage = String(describing: response.result.error)
                    print("Error while fetching: \(errorMessage)")
                    errorHandler(NetworkError.other)
                    return
                }
                
                do{ 
                    if let json = response.result.value {
                        let data = try self.parseResponse(json: json, type: type)
                        completion(data)
                    }
                }
                catch {
                    errorHandler(NetworkError.custom(error.localizedDescription))
                }
        }
    }
    
    func parseResponse <A:Codable>(json:Any,type:A.Type) throws -> A? {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let model = try JSONDecoder().decode(type, from: data)
            return model
        }
        return nil
    }
}
