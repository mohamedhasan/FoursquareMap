//
//  ClusterAnnotationView.swift
//  FoursquareMap
//
//  Created by Mohamed Hassan on 11/2/19.
//  Copyright © 2019 Mohamed Hassan. All rights reserved.
//

import UIKit
import MapKit

class ClusterAnnotationView: MKAnnotationView {

    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
        centerOffset = CGPoint(x: 0, y: -10)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func drawCluster(count:Int) -> UIImage {
        
        let pinWidth = CGFloat(34)
        let pinHeight = CGFloat(34)
        
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: pinWidth, height: pinHeight))
        return renderer.image { _ in
            
            UIColor.tealishBlue.setFill()
            UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: pinWidth, height: pinHeight)).fill()

            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white,
                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.paragraphStyle: paragraphStyle]
            let text = "\(count)"
            let size = text.size(withAttributes: attributes)
            let rect = CGRect(x: (pinWidth / 2) - (size.width / 2), y:(pinHeight / 2) - (size.height / 2), width: size.width, height: size.height)
            text.draw(in: rect, withAttributes: attributes)
        }
    }
    
    override func prepareForDisplay() {
        super.prepareForDisplay()
        self.canShowCallout = false
        displayPriority = .defaultHigh
        if let cluster = annotation as? MKClusterAnnotation {
            let count = cluster.memberAnnotations.count
            image = drawCluster(count: count)
        }
        
    }
    
}
