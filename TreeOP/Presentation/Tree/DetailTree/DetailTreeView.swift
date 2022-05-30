//

//  DetailTreeView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import MapKit

import Resolver

struct DetailTreeView: View {
    
    @ObservedObject var detailViewModel: DetailTreeViewModel
    
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion.init()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Species \(detailViewModel.glTree?.tree.species?.localizedCapitalized ?? String(localized: "notSpecified"))", comment: "speciesComment")
            
            Text("Height \(detailViewModel.glTree?.tree.height ?? 0)", comment: "heightComment")
            
            Text("Circumference \(detailViewModel.glTree?.tree.circumference ?? 0)", comment: "circumferenceComment")
            
            detailViewModel.displayFullAddress()
                .padding(.bottom, 5)
            
            Map(coordinateRegion: $mapRegion, interactionModes: .all , annotationItems: self.detailViewModel.annotationItems) { item in
                MapMarker(coordinate: self.detailViewModel.coordinates, tint: .red)
            }
        }
        
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationTitle(detailViewModel.displayTreeName())
        .navigationBarTitleDisplayMode(.large)
        
        .toolbar(content: {
            Button {
                detailViewModel.toggleFavorite()
            } label: {
                Image(systemName: detailViewModel.starIconName)
                    .foregroundColor(.yellow)
            }
        })
        
        .onAppear {
            detailViewModel.setStarIconName()
            
            self.detailViewModel.updateCoordinates { (updatedCoordinates) in
                self.mapRegion = MKCoordinateRegion(center: updatedCoordinates, span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailTreeView(detailViewModel: Resolver.resolve(args: GeolocatedTree.mock))
    }
}
