//
//  TreeOPApp.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI

@main
struct TreeOPApp: App {
    
    @StateObject private var favouriteTrees = FavouriteTrees()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                ListView()
                    .tabItem {
                        Image(systemName: "list.bullet")
                        Text("Trees")
                    }
                
                InfosView()
                    .tabItem {
                        Image(systemName: "questionmark.circle")
                        Text("General Infos")
                    }
            }
            .environmentObject(favouriteTrees)
        }
    }
}
