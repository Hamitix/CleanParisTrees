//
//  ContentView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct ListView: View {
    
    @StateObject var listViewModel: ListViewModel
    
    init(viewModel: ListViewModel = .init()) {
        _listViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            
            List{
                
                ForEach(listViewModel.records, id: \.self) { record in
                    NavigationLink(destination: DetailView(record: record)) {
                        Text("\(record.fields.name)")
                    }
                }

                .listRowSeparatorTint(Color("separator"))
                .listRowSeparator(.hidden, edges: .top)
            }
            .listStyle(.inset)
            .padding(.trailing)
            
            .navigationTitle(Text("titleMainView"))
        }
        .navigationViewStyle(.stack)
        .onAppear(perform: listViewModel.getTreesData)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
