//

//  DetailView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    let record: RecordsData
    
    @StateObject var detailViewModel: DetailViewModel
    
    init(record: RecordsData, viewModel: DetailViewModel = .init(record: RecordsData.sampleData)) {
        self.record = record
        _detailViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
        
            HStack(alignment: .center) {
                
                Spacer()
                Label {
                    Text(record.fields.name)
                        .titleStyle()
                } icon: {
                    Image(systemName: "leaf")
                        .foregroundColor(.green)
                }
                Spacer()
            }
            .padding(.bottom, 15)
            
            
            Text("Species \(record.fields.species.localizedCapitalized)", comment: "display the species of the tree")
            
            Text("Height \(record.fields.height)", comment: "display the height of the tree in meter")
            
            Text("Circumference \(record.fields.circumference)", comment: "display the circumference of the tree in centimetres")
            
            Text("Address \(record.fields.address.localizedCapitalized) \(record.fields.address2.localizedCapitalized)" , comment: "display the address where you can find this tree")
                .padding(.bottom, 5)
            
            Map(coordinateRegion: $detailViewModel.mapRegion, interactionModes: MapInteractionModes.all , annotationItems: [detailViewModel.record]) { record in
                MapMarker(coordinate: record.geometry.coordinateCL, tint: .red)
            }
            
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationTitle(Text(record.fields.name))
        .navigationBarTitleDisplayMode(.inline)
        
        .onAppear {
            self.detailViewModel.record = self.record
            self.detailViewModel.getMapCoordinates()
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(record: RecordsData.sampleData)
    }
}
