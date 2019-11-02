//
//  ViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController,UIGestureRecognizerDelegate {

    @IBOutlet public weak var mapView: MKMapView!
    var dataSource:[Place]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backgroundColor = UIColor.tealishBlue
        
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showInstructions))
        rightBarItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
        
        setupMap()
    }

    @objc func showInstructions() {
        
    }
    
    private func setupMap() {
        mapView.userTrackingMode = .follow
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didDragMap(_:)))
        panGesture.delegate = self
        mapView.addGestureRecognizer(panGesture)
        registerAnnotationViewClasses()
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(PlaceViewModel.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
        mapView.register(ClusterAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultClusterAnnotationViewReuseIdentifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadPlaces()
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    
    @objc func didDragMap(_ sender: UIGestureRecognizer) {
        if sender.state == .ended {
            loadPlaces()
        }
    }
    
    private func loadPlaces() {
        
        let center = mapView.centerCoordinate
        mapView.removeAnnotations(mapView.annotations)
        PlacesApi.shared.searchPlaces(source: .foursquare, lat: center.latitude, lng: center.longitude, completion: { (response) in
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
    }
    
    public func mapView(_ mapView: MKMapView,
                        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let viewModel = annotation as? PlaceViewModel else {
            return nil
        }
        return viewModel.annotationView()
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
