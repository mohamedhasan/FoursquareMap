//
//  MapViewPresenter.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class MapViewPresenter: NSObject {

    private var model:[Place]
    private var interactor:FoursquarePlaceInteractor
    weak var delegate:MapViewerProtocol? { didSet { setup() }}
    
    private func setup() {
        delegate?.setupView()
        interactor.completionHandler =  { (places) in
            self.model = places
            self.delegate?.showAnnotations(self.getAnnotations())
        }
        interactor.errorHandler = { (error) in
            self.delegate?.showError(error)
        }
    }
    
    public init(dataProvider:DataProvider) {
        self.model = [Place]()
        self.interactor = FoursquarePlaceInteractor(dataProvider:dataProvider)
    }
    
    public func loadPlaces(coordinate:CLLocationCoordinate2D) {
        interactor.fetchPlaces(coordinate: coordinate)
    }
    
    private func getAnnotations() -> [MKAnnotation] {
        var annotations = [MKAnnotation]()
        for place in model {
            let annotation = MapAnnotation(place: place)
            annotations.append(annotation)
        }
        return annotations
    }
}
