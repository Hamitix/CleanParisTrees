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
        Text(K.titleMainView)
            .padding()
        
        List(mainViewModel.records) { record in
            ListTreeItem(record: record)
        }.listStyle(.inset)
        
        .onAppear(perform: mainViewModel.getTreesData)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
