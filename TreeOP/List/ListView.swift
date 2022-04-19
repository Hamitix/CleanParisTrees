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
        
        VStack {
            NavigationView {
                List{
                    ForEach(listViewModel.records, id: \.self) { record in
                        ListItem(record: record)
                            .onAppear {
                                listViewModel.loadMoreRowsIfNeeded(currentRow: record)
                            }
                    }
                    .listRowSeparatorTint(Color("separator"))
                    .listRowSeparator(.hidden, edges: .top)
                }
                .listStyle(.inset)
                .padding(.trailing)
                .navigationTitle(Text("titleMainView"))
            }
            
            if(listViewModel.isLoadingRows) {
                ProgressView()
            }
        }
        .navigationViewStyle(.stack)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
