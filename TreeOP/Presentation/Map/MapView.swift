//
//  MapView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 16/05/2022.
//

import SwiftUI
import Resolver

import MapKit
import CoreLocation

struct MapView: View {
    
    @InjectedObject var mapViewModel: MapViewModel
    
    @State private var tracking: MapUserTrackingMode = .none

    var body: some View {
        
        ZStack(alignment: .center) {
            Color(mapViewModel.networkMonitor.isDeviceConnectedToInternet() ? "background" : "redError")
                .ignoresSafeArea(.all, edges: .top)
                .padding(.bottom)
                .animation(.easeOut(duration: 0.5), value: mapViewModel.networkMonitor.fetchStrategy)
                
            VStack(alignment: .center, spacing: 10) {
                
                Text("Map")
                
                Map(coordinateRegion: $mapViewModel.mapRegion, interactionModes: .all , showsUserLocation: true, userTrackingMode: $tracking ,annotationItems: mapViewModel.treeStore.treeList) { item in
                    MapAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.lat, longitude: item.lng)) {
                        
                        CustomMapMarker(isFav: false, name: item.tree.name ?? String(localized: "No Name"))
                    }
                }
                .cornerRadius(20)
            }
        }
        
        .overlay(alignment: .bottomTrailing) {
            Button {
                mapViewModel.centerMapOnUser()
            } label: {
                CenterOnUserIcon()
            }
            .offset(x: -10, y: -20)
        }
        
        .overlay(alignment: .bottom, content: {
            if !mapViewModel.networkMonitor.isDeviceConnectedToInternet() {
                    NoConnectionView()
            }
        })
        
        .onAppear {
            mapViewModel.initLocation()
        }
        
        .task {
            await mapViewModel.getTrees()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
            .preferredColorScheme(.dark)
    }
}
