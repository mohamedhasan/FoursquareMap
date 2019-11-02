//
//  PlaceViewModel.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class PlaceViewModel: NSObject {

    private let model:Place
    
    public init(model:Place) {
        self.model = model
    }
    
    func mapPin() -> UIImage {
        return UIImage(named: "restaurantPin")!
    }
    
    func pinIdentifier() -> String {
        return "pinIdentifier"
    }
    
}

extension PlaceViewModel: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(model.lat, model.lng)
    }
    public var title: String? {
        return model.title
    }
    public var subtitle: String? {
        return model.address
    }
}
