//
//  JsonParser.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import Foundation

class JsonParser: NSObject {

    class func parseResponse <A:Codable>(json:Any,type:A.Type) throws -> A? {
        if let data = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted) {
            let model = try JSONDecoder().decode(type, from: data)
            return model
        }
        return nil
    }
    
}
