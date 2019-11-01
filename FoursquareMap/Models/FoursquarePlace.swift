//
//  FoursquarePlace.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

struct FoursquarePlaceContact: Codable {
    let phone:String!
    let formattedPhone:String!
    let twitter:String!
    let instagram:String!
    let facebook:String!
    let facebookUsername:String!
}

struct FoursquarePlaceLocation: Codable {
    let address:String!
    let crossStreet:String!
    let lat:Double!
    let lng:Double!
}

struct FoursquareObj: Codable {
    let venues:[FoursquarePlace]!
}

struct FoursquareResponse: Codable {
    let response:FoursquareObj!
}

struct FoursquarePlace: Codable {
    let id:String!
    let name:String!
    let contact:FoursquarePlaceContact!
    let location:FoursquarePlaceLocation!
}

extension FoursquarePlace:PlaceProtocol {
    var title: String { get {return self.name}}
    var address: String  { get {return self.name}}
    var lat: Double  { get {return self.location.lat}}
    var lng: Double  { get {return self.location.lng}}
}
