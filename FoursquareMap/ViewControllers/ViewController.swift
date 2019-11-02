//
//  ViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet public weak var mapView: MKMapView!
    var dataSource:[Place]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.tealishBlue
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlaces()
    }
    private func loadPlaces() {
        
        mapView.removeAnnotations(mapView.annotations)
        PlacesApi.shared.searchPlaces(source: .foursquare, lat: 40.74859953, lng: -73.985806, completion: { (response) in
            if let searchResponse = response {
                if searchResponse.isSuccess {
                    self.addAnnotations(for: searchResponse.data)
                } else {
                    self.presentError(error: .other)
                }
            } else {
                self.presentError(error: .other)
            }
        }) { (error) in
            self.presentError(error: error)
        }
    }
}

extension ViewController: MKMapViewDelegate {
    
    private func addAnnotations(for places:[Place]) {
        
        self.dataSource = places
        var annotations = [MKAnnotation]()
        for car in places {
            let annotation = PlaceViewModel(model: car)
            annotations.append(annotation)
        }
        mapView.addAnnotations(annotations)
        mapView.showAnnotations(annotations, animated: true)
    }
    
    public func mapView(_ mapView: MKMapView,
                        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let viewModel = annotation as? PlaceViewModel else {
            return nil
        }
        
        let identifier = viewModel.pinIdentifier()
        let annotationView: MKAnnotationView
        if let existingView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) {
            annotationView = existingView
        } else {
            annotationView = MKAnnotationView(annotation: viewModel,
                                              reuseIdentifier: identifier)
        }
        annotationView.image = viewModel.mapPin()
        annotationView.canShowCallout = true
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
    }
    
}

extension ViewController {
    func presentError(error:NetworkError) {
        
        let title = NSLocalizedString("Error", comment: "")
        let message = error.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = NSLocalizedString("cancel", comment: "")
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
