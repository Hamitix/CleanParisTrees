//
//  TreeOPApp.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI
import Resolver

import DataLayer

@main
struct TreeOPApp: App {
    
    @StateObject private var coreDataController = CoreDataController.shared
    
    @Injected private var networkMonitor: NetworkMonitor
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TreeListView()
                    .tabItem {
                        Image(systemName: String(localized: "leafIcon"))
                        Text("Trees")
                    }
                
                
                ClusterMapView()
                    .tabItem {
                        Image(systemName: String(localized: "mapIcon"))
                        Text("Map")
                    }
                    
                WeatherInfoView()
                    .tabItem {
                        Image(systemName: String(localized: "weatherIcon"))
                        Text("Weather")
                    }
            }
            .environment(\.managedObjectContext, coreDataController.container.viewContext)
            
            .onAppear {
                networkMonitor.startMonitoring()
            }
            .onDisappear {
                networkMonitor.stopMonitoring()
            }
        }
    }
}
