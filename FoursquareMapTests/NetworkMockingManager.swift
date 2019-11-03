//
//  NetworkMockingManager.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class NetworkMockingManager: DataProvider {

    let bundle:Bundle!
    var showError = false
    
    init(bundle:Bundle) {
        self.bundle = bundle
    }
    
    func perfromRequest <T:Codable>(request:RequestProtocol, of type: T.Type, completion: @escaping (T?) -> Void,errorHandler: @escaping (NetworkError) -> Void) {
        
        if showError {
            errorHandler(.other)
            return
        }
        let mockName = request.path.mockName
        if let path = bundle.path(forResource: mockName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
            let decoder = JSONDecoder()
            let responseMock = try decoder.decode(type.self, from: data)
            completion(responseMock)
        }
        catch {
            errorHandler(.other)
            }
        }

    }
}
