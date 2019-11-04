//
//  ViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/1/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet public weak var mapView: MKMapView!
    lazy var presenter:MapViewPresenter = {
        let presenter = MapViewPresenter(dataProvider:NetworkManager.sharedInstance)
        presenter.delegate = self
        return presenter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    func setupView() {
        setupNavBar()
        setupMap()
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
        mapView.register(MapViewPresenter.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier)
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
        presenter.loadPlaces(coordinate: mapView.centerCoordinate)
    }
}

extension MapViewController: MKMapViewDelegate {
    
    public func mapView(_ mapView: MKMapView,
                        viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let mapAnnotation = annotation as? MapAnnotation else {
            return nil
        }
        return mapAnnotation.annotationView()
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        
        guard let mapAnnotation = view.annotation as? MapAnnotation else {
            return
        }
        if let detailsViewController = storyboard?.instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController {
            let presenter = DetailsViewPresenter(dataProvider: NetworkManager.sharedInstance, place: mapAnnotation.place)
            detailsViewController.presenter = presenter
            present(detailsViewController, animated: true, completion: nil)
        }
    }
}

extension MapViewController:MapViewerProtocol {
    func showAnnotations(_ annotations:[MKAnnotation]) {
        if annotations.count > 0 {
            mapView.removeAnnotations(mapView.annotations)
        }
        mapView.addAnnotations(annotations)
    }
    
    func showError(_ error: NetworkError) {
        presentError(error)
    }
}
