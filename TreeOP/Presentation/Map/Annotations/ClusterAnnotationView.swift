//
//  LocationDataMapClusterView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 17/05/2022.
//

import MapKit

final class ClusterAnnotationView: MKAnnotationView {
    
    static let reuseId = "ClusterAnnotationIdentifier"
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let cluster = annotation as? MKClusterAnnotation else { return }
            
            displayPriority = .defaultHigh
            
            let rect = CGRect(x: 0, y: 0, width: 40, height: 40)
            
            image = UIGraphicsImageRenderer.image(for: cluster.memberAnnotations, in: rect)
            
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        collisionMode = .circle
    }
    
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

