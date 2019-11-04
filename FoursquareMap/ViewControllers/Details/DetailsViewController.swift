//
//  DetailsViewController.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/3/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,DetailsViewerProtocol {
    
    var presenter:DetailsViewPresenter?
    @IBOutlet public weak var labelTitle: UILabel!
    @IBOutlet public weak var labelAddress: UILabel!
    @IBOutlet public weak var stackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.delegate = self
    }
    
    @IBAction func close() {
        dismiss(animated: true, completion: nil)
    }
    
    func showTitle(title:String) {
        labelTitle.text = title
    }
    
    func showAddress(address:String) {
        labelAddress.text = address
    }
    
    func showSocialButtons(_ buttons: [UIButton]) {
        for button in buttons {
            stackView.addArrangedSubview(button)
        }
    }
    
    func showError(_ error: NetworkError) {
        self.presentError(error)
    }
    

}
