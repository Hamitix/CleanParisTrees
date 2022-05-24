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


extension UIImage {
    func imageWithColor(tintColor: UIColor) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        
        let context = UIGraphicsGetCurrentContext()!
        context.translateBy(x: 0, y: self.size.height)
        context.scaleBy(x: 1.0, y: -1.0);
        context.setBlendMode(.normal)
        
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height) as CGRect
        context.clip(to: rect, mask: self.cgImage!)
        tintColor.setFill()
        context.fill(rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
