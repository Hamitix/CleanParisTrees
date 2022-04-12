//
//  DetailView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 12/04/2022.
//

import SwiftUI

struct DetailView: View {
    
    let record: RecordsData
    
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
                
            Spacer()
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        
        .navigationTitle(Text(record.fields.name))
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(record: RecordsData.sampleData)
    }
}
