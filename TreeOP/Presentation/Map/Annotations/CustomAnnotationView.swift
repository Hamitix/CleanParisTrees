//
//  CustomAnnotationView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 20/05/2022.
//

import MapKit


final class CustomAnnotationView: MKAnnotationView {
    
    override var annotation: MKAnnotation? {
        didSet {
            guard let annotation = annotation as? TreeAnnotation
            else { return }
            
            clusteringIdentifier = ClusterAnnotationView.reuseId
            
            image = annotation.image   
        }
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
