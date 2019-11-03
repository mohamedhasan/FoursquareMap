//
//  MapAnnotation.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class MapAnnotation:NSObject, MKAnnotation {

    let place:Place
    
    init(place:Place) {
        self.place = place
    }
    
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2DMake(place.lat, place.lng)
    }
    
    public var title: String? {
        return place.title
    }
    
    public var subtitle: String? {
        return place.address
    }
    
    func annotationView() -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: pinIdentifier())
        annotationView.image = mapPin()
        annotationView.canShowCallout = true
        annotationView.clusteringIdentifier = "cluster"
        
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.setImage(calloutImage(), for: .normal)
        annotationView.rightCalloutAccessoryView = button
        
        return annotationView
    }
}

extension MapAnnotation {
    func mapPin() -> UIImage {
        return UIImage(named: "restaurantPin")!
    }
    
    func calloutImage() -> UIImage {
        return UIImage(named: "more")!
    }
    
    func pinIdentifier() -> String {
        return "pinIdentifier"
    }
    
}
