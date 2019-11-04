//
//  FoursquarePlaceDetailsResponse.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/4/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

struct FoursquareDetailsObj: Codable {
    let venue:FoursquarePlace!
}

class FoursquareDetailsResponse: NSObject, ResponseProtocol {
    let response:FoursquareDetailsObj!
    let meta:FoursquareMeta?
    
    var data: [Place] { get {
        if let venue = self.response?.venue {
            return [venue]
        } else {
            return [Place]()
        }
        }}
    var error: String? {get {nil}}
    var isSuccess: Bool {get {return self.meta?.code == 200}}
}
