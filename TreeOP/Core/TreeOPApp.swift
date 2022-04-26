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
                TreeListView()
                    .tabItem {
                        Image(systemName: String(localized: "listBulletIcon"))
                        Text("Trees")
                    }
                
                WeatherInfoView()
                    .tabItem {
                        Image(systemName: String(localized: "questionMarkCircleIcon"))
                        Text("General Infos")
                    }
            }
            .environmentObject(favouriteTrees)
        }
    }
}
