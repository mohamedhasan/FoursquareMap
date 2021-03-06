//
//  MapViewerProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewerProtocol:NSObject {
    func showAnnotations(_ annotations:[MKAnnotation])
    func showError(_ error:NetworkError)
    func setupView()
}
