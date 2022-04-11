//
//  ListTreeItem.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 11/04/2022.
//

import SwiftUI

struct ListTreeItem: View {
    
    let record: RecordsData
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {    
            Text(record.fields.name)
                .bold()
                .font(.title2)
                .textCase(.uppercase)
                .padding(.vertical, 5)
            
            Text("\(K.TreeItem.species)\(record.fields.species.capitalized)")
                            
            Text("\(K.TreeItem.height)\(record.fields.height) m")
            
            Text("\(K.TreeItem.circumference)\(record.fields.circumference) cm")
            
            Text("\(K.TreeItem.adress)\(record.fields.adress.capitalized)")
                .padding(.bottom, 5)
        }
        .padding(.trailing)
    }
}

struct ListTreeItem_Previews: PreviewProvider {
    static var previews: some View {
        ListTreeItem(record: RecordsData.sampleData)
    }
}
