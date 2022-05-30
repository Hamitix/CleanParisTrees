//
//  ClusterMapView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 23/05/2022.
//

import SwiftUI
import MapKit
import Resolver

struct ClusterMapView: View {
    
    @InjectedObject private var mapViewModel: MapViewModel
    
    var body: some View {
        
        MapViewUIView(mapViewModel: mapViewModel)
        
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

struct ClusterMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}
