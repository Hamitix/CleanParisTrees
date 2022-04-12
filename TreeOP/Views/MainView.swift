//
//  ContentView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct MainView: View {
    
    @StateObject var mainViewModel: MainViewModel
    
    init(viewModel: MainViewModel = .init()) {
        _mainViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        
        NavigationView {
            List(mainViewModel.records) { record in
                
                NavigationLink(destination: DetailView(record: record)) {
                    Text("\(record.fields.name)")
                }
                .listRowSeparatorTint(Color("separator"))
                .listRowSeparator(.hidden, edges: .top)
            }
            .listStyle(.inset)
            .padding(.trailing)
            
            .navigationTitle(Text("titleMainView"))
            .onAppear(perform: mainViewModel.getTreesData)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
