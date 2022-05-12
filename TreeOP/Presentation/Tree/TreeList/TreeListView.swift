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
            
            if listViewModel.filteredTrees.isEmpty {
                if listViewModel.isLoadingRows {
                    ProgressView()
                } else {
                    Text("treeListEmpty")
                }
            }
            else {
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
                    
                    .refreshable {
                        await listViewModel.refreshableAction()
                    }
                    
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
                
                if listViewModel.isLoadingRows && !listViewModel.filteredTrees.isEmpty {
                    ProgressView()
                        .padding(.bottom)
                }
            }
        }
        .task {
            if listViewModel.filteredTrees.isEmpty {
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
