//
//  DetailsViewerProtocol.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/4/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

protocol DetailsViewerProtocol: NSObject {
    func showSocialButtons(_ buttons:[UIButton])
    func showError(_ error:NetworkError)
    func showTitle(title:String)
    func showAddress(address:String)
}
