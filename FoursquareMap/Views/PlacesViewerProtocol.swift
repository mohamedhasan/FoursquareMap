//
//  PlacesViewerProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol PlacesViewerProtocol:NSObject {
    func showPlaces(_ places:[Place])
    func showError(_ error:NetworkError)
}
