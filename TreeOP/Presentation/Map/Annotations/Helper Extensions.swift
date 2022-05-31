//
//  Helpers.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 20/05/2022.
//

import Foundation
import MapKit

extension UIGraphicsImageRenderer {
    static func image(for annotations: [MKAnnotation], in rect: CGRect) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        
        let countText = "\(annotations.count)"
        
        return renderer.image { _ in
            
            UIColor(.black).setFill()
            
            UIBezierPath(ovalIn: rect).fill()
            
            (UIColor(named: "khaki") ?? UIColor(.green)).setFill()
            
            UIBezierPath(roundedRect: CGRect(x: 8, y: 8, width: 24, height: 24), cornerRadius: 12).fill()
            
            countText.drawForCluster(in: rect)
        }
    }
}

extension String {
    func drawForCluster(in rect: CGRect) {
        let attributes = [ NSAttributedString.Key.foregroundColor: UIColor.black,
                           NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 14)]
        let textSize = self.size(withAttributes: attributes)
        let textRect = CGRect(x: (rect.width / 2) - (textSize.width / 2),
                              y: (rect.height / 2) - (textSize.height / 2),
                              width: textSize.width,
                              height: textSize.height)
        
        self.draw(in: textRect, withAttributes: attributes)
    }
}
