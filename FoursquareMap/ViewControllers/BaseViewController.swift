//
//  BaseViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    func presentError(_ error:NetworkError) {
        let title = NSLocalizedString("Error", comment: "")
        let message = error.localizedDescription
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancel = NSLocalizedString("cancel", comment: "")
        alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

}
