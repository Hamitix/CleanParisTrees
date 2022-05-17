//
//  TreeOPApp.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import SwiftUI

@main
struct TreeOPApp: App {
    
    @StateObject private var coreDataController = CoreDataController.shared
    
    private let networkMonitor = NetworkMonitor.shared
    
    var body: some Scene {
        WindowGroup {
            TabView {
                TreeListView()
                    .tabItem {
                        Image(systemName: String(localized: "leafIcon"))
                        Text("Trees")
                    }
                
                
                MapView()
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
