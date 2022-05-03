//
//  TreeListView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct TreeListView: View {
    
    @StateObject private var listViewModel: TreeListViewModel
    
    init(viewModel: TreeListViewModel = .init()) {
        _listViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            
            NavigationView {
                List {
                    ForEach(listViewModel.filteredTrees) { item in
                        TreeItemView(item: item)
                            .task {
                                await listViewModel.loadMoreRowsIfNeeded(currentItem: item)
                            }
                            .listRowSeparatorTint(Color("separator"))
                            .listRowSeparator(.hidden, edges: .top)
                    }
                }
                .listStyle(.inset)
                .padding(.trailing)
                
                .animation(.default, value: listViewModel.isFilteringFavourites)
                
                .toolbar(content: {
                    Button {
                        listViewModel.toggleFilterFavourites()
                    } label: {
                        Text(LocalizedStringKey(listViewModel.filterButtonName))
                    }
                })
                
                .navigationTitle(Text("titleMainView"))
                .navigationViewStyle(.stack)
            }
            
            if listViewModel.isLoadingRows {
                ProgressView()
                    .padding(.bottom)
            }
        }
        .task {
            if listViewModel.filteredTrees.count == 0 {
                await self.listViewModel.getTreesData()
            }
        }
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        TreeListView()
    }
}
