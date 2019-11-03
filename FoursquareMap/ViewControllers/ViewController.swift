//
//  ViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class ViewController: BaseViewController, UIGestureRecognizerDelegate {

    @IBOutlet public weak var mapView: MKMapView!
    var dataSource:[Place]?
    var viewModel:MapViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupMap()
        setupModelView()
    }

    private func setupNavBar() {
        self.navigationController?.navigationBar.backgroundColor = UIColor.tealishBlue
        let rightBarItem = UIBarButtonItem(image: UIImage(named: "help"), style: .plain, target: self, action: #selector(showInstructions))
        rightBarItem.tintColor = .black
        navigationItem.rightBarButtonItem = rightBarItem
    }
    
    private func setupMap() {
        mapView.userTrackingMode = .follow
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didDragMap(_:)))
        panGesture.delegate = self
        mapView.addGestureRecognizer(panGesture)
        registerAnnotationViewClasses()
    }
    
    private func setupModelView() {
        viewModel = MapViewModel(dataProvider:NetworkManager.sharedInstance)
        viewModel?.delegate = self
    }
    
    @objc func showInstructions() {
        let title = NSLocalizedString("Welcome!", comment: "")
        let message = NSLocalizedString("Navigate through the map to find your favourite places to eat!", comment: "")
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = NSLocalizedString("Got it", comment: "")
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        alert.view.tintColor = UIColor.tealishBlue
        self.present(alert, animated: true, completion: nil)
    }
    
    private func registerAnnotationViewClasses() {
        mapView.register(MapViewModel.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
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
        viewModel?.loadPlaces(coordinate: mapView.centerCoordinate)
    }
}

extension ViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView,
                        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation else {
            return nil
        }
        return mapAnnotation.annotationView()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        
    }
}

extension ViewController:PlacesViewerProtocol {
    func showPlaces(_ places: [Place]) {
        if let annotations = viewModel?.getAnnotations() {
            if annotations.count > 0 {
                mapView.removeAnnotations(mapView.annotations)
            }
            mapView.addAnnotations(annotations)
        }
    }
    
    func showError(_ error: NetworkError) {
        presentError(error)
    }
}
