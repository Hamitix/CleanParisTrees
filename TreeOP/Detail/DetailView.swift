//

//  DetailView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    @ObservedObject var detailViewModel = DetailViewModel()
    
    @State private var mapRegion: MKCoordinateRegion = MKCoordinateRegion.init()
    
    init(record: RecordsData) {
        detailViewModel.record = record
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            Text("Species \(detailViewModel.record?.fields.species?.localizedCapitalized ?? "No species")", comment: "display the species of the tree")
            
            
            Text("Height \(detailViewModel.record?.fields.height ?? 0)", comment: "display the height of the tree in meter")
            
            Text("Circumference \(detailViewModel.record?.fields.circumference ?? 0)", comment: "display the circumference of the tree in centimetres")
            
            Text("Address \(detailViewModel.record?.fields.address.localizedCapitalized ?? "No Address") \(detailViewModel.record?.fields.address2?.localizedCapitalized ?? "")" , comment: "display the address where you can find this tree")
                .padding(.bottom, 5)
            
            Map(coordinateRegion: $mapRegion, interactionModes: .all , annotationItems: self.detailViewModel.annotationItems) { item in
                MapAnnotation(coordinate: self.detailViewModel.cllCoordinates) {
                    PlaceMarkerView(title: detailViewModel.record?.fields.name)
                }
                
            }
        }
        
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationTitle(displayTreeName())
        .navigationBarTitleDisplayMode(.large)
        
        .toolbar(content: {
            Button {
                toggleFavorite()
            } label: {
                displayStarIcon()
            }
        })
        
        .onAppear {
            if(detailViewModel.longitude == 0) {
                self.detailViewModel.updateCoordinates()
            }
            
            if(self.mapRegion.center.longitude == 0) {
                self.mapRegion = MKCoordinateRegion(center: detailViewModel.cllCoordinates, span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
            }
        }
    }
    
    func displayTreeName() -> Text {
        return Text(LocalizedStringKey(detailViewModel.record?.fields.name ?? "No Name"), comment: "Indicate either the title or a default placeholder")
    }
    
    func toggleFavorite() {
        if let record = detailViewModel.record {
            favouriteTrees.toggleFavorite(tree: record.fields)
        }
    }
    
    func displayStarIcon() -> Image? {
        if let record = self.detailViewModel.record {
            return  Image(systemName: favouriteTrees.isFavorite(tree: record.fields) ? "star.fill" : "star")
        }
        return nil
    }
    
    struct DetailView_Previews: PreviewProvider {
        static var previews: some View {
            DetailView(record: RecordsData.sampleData)
        }
    }
}
