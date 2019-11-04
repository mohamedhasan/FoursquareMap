//
//  MapViewMock.swift
//  FoursquareMapTests
//
//  Created by Mohamed Hassan on 11/4/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class MapViewMock: NSObject,MapViewerProtocol {
    
    public var mockedAnnotations:[MKAnnotation]?
    public var mockedError:NetworkError?
    
    func showAnnotations(_ annotations: [MKAnnotation]) {
        self.mockedAnnotations = annotations
    }
    
    func showError(_ error: NetworkError) {
        self.mockedError = error
    }
}

extension MapViewMock {
    func setupView() {}
}
