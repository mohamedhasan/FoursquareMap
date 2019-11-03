//
//  DataProviderProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

protocol DataProvider {
    func perfromRequest <T:Codable>(request:RequestProtocol, of type: T.Type, completion: @escaping (T?) -> Void,errorHandler: @escaping (NetworkError) -> Void)
}
