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

    var model:[Place]
    lazy private var interactor:FoursquarePlaceInteractor? = { return interactorInstance() }()
    
    private let dataProvider:DataProvider
    weak var delegate:PlacesViewerProtocol?
    
    public init(dataProvider:DataProvider) {
        self.model = [Place]()
        self.dataProvider = dataProvider
    }
    
    private func interactorInstance() -> FoursquarePlaceInteractor {
        return FoursquarePlaceInteractor(dataProvider:dataProvider, onSuccess: { (places) in
            self.model = places
            self.delegate?.showAnnotations(self.getAnnotations())
        }, onFailure: { (error) in
            self.delegate?.showError(error)
        })
    }
    
    public func loadPlaces(coordinate:CLLocationCoordinate2D) {
        interactor?.fetchPlaces(coordinate: coordinate)
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
