//
//  ListTreeItem.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 11/04/2022.
//

import SwiftUI

struct ListTreeItem: View {
    
    let record: RecordsData
    
    @State var selected = false
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 5) {
            Text(record.fields.name)
                .bold()
                .font(.title2)
                .textCase(.uppercase)
                .padding(.vertical, 5)
            
            if(selected) {
                Text("\(K.TreeItem.species)\(record.fields.species.capitalized)")
                
                Text("\(K.TreeItem.height)\(record.fields.height) m")
                
                Text("\(K.TreeItem.circumference)\(record.fields.circumference) cm")
                
                Text("\(K.TreeItem.adress)\(record.fields.adress.capitalized)")
                    .padding(.bottom, 5)
            }
        }
        .padding(.trailing)
        .frame(minWidth: 100, idealWidth: .infinity, maxWidth: .infinity, alignment: .leading)
        .background()
        .onTapGesture {
            self.selected.toggle()
        }
    }
}

struct ListTreeItem_Previews: PreviewProvider {
    static var previews: some View {
        ListTreeItem(record: RecordsData.sampleData)
    }
}
