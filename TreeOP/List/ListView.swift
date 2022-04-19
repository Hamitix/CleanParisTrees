//
//  ContentView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct ListView: View {
    
    @StateObject private var listViewModel: ListViewModel
    
    init(viewModel: ListViewModel = .init()) {
        _listViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            
            List{
                ForEach(listViewModel.records, id: \.self) { record in
                    ListItem(record: record)
                }
                .listRowSeparatorTint(Color("separator"))
                .listRowSeparator(.hidden, edges: .top)
            }
            .listStyle(.inset)
            .padding(.trailing)
            
            .navigationTitle(Text("titleMainView"))
        }
        .navigationViewStyle(.stack)
        .onAppear{
            if(listViewModel.records.count == 0) {
                listViewModel.getTreesData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
