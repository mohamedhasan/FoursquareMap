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
    
    func annotationView() -> MKAnnotationView {
        let annotationView = MKAnnotationView(annotation: self, reuseIdentifier: self.pinIdentifier())
        annotationView.image = self.mapPin()
        annotationView.canShowCallout = true
        annotationView.clusteringIdentifier = "cluster"
        
        let btn = UIButton(type: .custom)
        btn.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        btn.setImage(UIImage(named: "more"), for: .normal)
        annotationView.rightCalloutAccessoryView = btn
        
        return annotationView
    }
}
