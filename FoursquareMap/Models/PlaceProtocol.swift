//
//  Place.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol Place {
    var placeId:String { get }
    var title:String { get }
    var address:String { get }
    var lat:Double { get }
    var lng:Double { get }
    var phone:String { get }
    var twitter:String? { get }
    var instagram:String? { get }
    var facebook:String? { get }
}

protocol ResponseProtocol:NSObject,Codable {
    var data:[Place] { get }
    var error:String? { get }
    var isSuccess:Bool { get }
}
