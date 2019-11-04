//
//  DetailsViewPresenter.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/4/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit

class DetailsViewPresenter: NSObject {

    private var model:Place
    private var interactor:FoursquarePlaceInteractor
    weak var delegate:DetailsViewerProtocol? { didSet { setup() }}
    
    
    public init(dataProvider:DataProvider, place:Place) {
        self.interactor = FoursquarePlaceInteractor(dataProvider:dataProvider)
        self.model = place
    }
    
    private func setup() {
        interactor.completionHandler =  { (places) in
            if let place = places.first {
                self.model = place
                self.delegate?.showTitle(title: self.model.title)
                self.delegate?.showAddress(address: self.model.address)
                self.showSocialMedia()
            }
        }
        interactor.errorHandler = { (error) in
            self.delegate?.showError(error)
        }
        interactor.loadPlaceDetails(placeId: model.placeId)
    }
    
    @objc private func openInstagram(){
        if let instagram = model.instagram {
            let urlString = "https://www.instagram.com/\(instagram)"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc private func openFacebook(){
        if let facebook = model.facebook {
            let urlString = "https://www.facebook.com/\(facebook)"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    @objc private func openTwitter(){
        if let twitter = model.twitter {
            let urlString = "https://twitter.com/\(twitter)"
            if let url = URL(string: urlString) {
                UIApplication.shared.open(url)
            }
        }
    }
    
    private func buttonWithImage(imageName:String) -> UIButton {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        button.setImage(UIImage(named: imageName), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        let widthConstraint  = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.width, multiplier: 1, constant: 100)
        let heightConstraint = NSLayoutConstraint(item: button, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.height, multiplier: 1, constant: 100)
        button.addConstraints([widthConstraint, heightConstraint])
        return button
    }
        
    private func showSocialMedia() {
        
        var buttons = [UIButton]()
        if model.facebook?.count ?? 0 > 0 {
            let button = buttonWithImage(imageName: "facebook")
            button.addTarget(self, action: #selector(openFacebook), for: .touchUpInside)
            buttons.append(button)
        }
        if model.twitter?.count ?? 0 > 0 {
            let button = buttonWithImage(imageName: "twitter")
            button.addTarget(self, action: #selector(openTwitter), for: .touchUpInside)
            buttons.append(button)
        }
        if model.instagram?.count ?? 0 > 0 {
            let button = buttonWithImage(imageName: "instagram")
            button.addTarget(self, action: #selector(openInstagram), for: .touchUpInside)
            buttons.append(button)
        }
        delegate?.showSocialButtons(buttons)
    }
}
