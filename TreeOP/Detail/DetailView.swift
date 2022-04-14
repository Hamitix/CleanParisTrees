//

//  DetailView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    @ObservedObject var detailViewModel = DetailViewModel()
    
    @State var mapRegion: MKCoordinateRegion = MKCoordinateRegion.init()
    
    init(record: RecordsData) {
        detailViewModel.record = record
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            
            HStack(alignment: .center) {
                
                Spacer()
                Label {
                    Text(detailViewModel.record?.fields.name ?? "No name")
                        .titleStyle()
                } icon: {
                    Image(systemName: "leaf")
                        .foregroundColor(.green)
                }
                Spacer()
            }
            .padding(.bottom, 15)
            
            Text("Species \(detailViewModel.record?.fields.species.localizedCapitalized ?? " No species")", comment: "display the species of the tree")
            
            Text("Height \(detailViewModel.record?.fields.height ?? 0)", comment: "display the height of the tree in meter")
            
            Text("Circumference \(detailViewModel.record?.fields.circumference ?? 0)", comment: "display the circumference of the tree in centimetres")
            
            Text("Address \(detailViewModel.record?.fields.address.localizedCapitalized ?? "No Address") \(detailViewModel.record?.fields.address2.localizedCapitalized ?? "")" , comment: "display the address where you can find this tree")
                .padding(.bottom, 5)
            
            
            Map(coordinateRegion: self.$mapRegion, interactionModes: .all , annotationItems: self.detailViewModel.annotationItems ) { item in
                MapMarker(coordinate: detailViewModel.cllCoordinates, tint: .red)
            }
        }
        
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationTitle(Text(detailViewModel.record?.fields.name ?? "No name"))
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            self.detailViewModel.updateCoordinates()
    
            self.mapRegion = MKCoordinateRegion(center: detailViewModel.cllCoordinates, span: MKCoordinateSpan(latitudeDelta: K.Map.latitudeDelta, longitudeDelta: K.Map.longitudeDelta))
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(record: RecordsData.sampleData)
    }
}
