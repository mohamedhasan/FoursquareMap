//
//  PlaceProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol PlaceProtocol {
    
    var title:String { get }
    var address:String { get }
    var lat:Double { get }
    var lng:Double { get }

}
