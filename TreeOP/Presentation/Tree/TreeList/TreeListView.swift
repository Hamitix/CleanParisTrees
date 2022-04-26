//
//  ContentView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI


struct TreeListView: View {
    
    @EnvironmentObject var favouriteTrees: FavouriteTrees
    
    @StateObject private var listViewModel: TreeListViewModel
    
    init(viewModel: TreeListViewModel = .init()) {
        _listViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List(listViewModel.filteredTrees) { item in
                    
                    TreeListItem(item: item)
                        .task {
                            await listViewModel.loadMoreRowsIfNeeded(currentItem: item)
                        }
                    
                        .listRowSeparatorTint(Color("separator"))
                        .listRowSeparator(.hidden, edges: .top)
                    
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button {
                                listViewModel.toggleFavorite(tree: item.tree)
                            } label: {
                                Image(systemName: String(localized:"starIcon"))
                            }
                            .tint(.yellow)
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
        .onAppear {
            self.listViewModel.setup(favTrees: self.favouriteTrees)
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
