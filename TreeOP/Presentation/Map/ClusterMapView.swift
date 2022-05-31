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
        
        NavigationView {
            
            VStack {
                
                NavigationLink(destination: DetailTreeView(detailViewModel: Resolver.resolve(args: mapViewModel.selectedTree)), isActive: $mapViewModel.navigateToSelectedTreeDetailView) {
                    EmptyView()
                }
                
                MapViewUIView()
            }

            .overlay(alignment: .bottom, content: {
                if !mapViewModel.networkMonitor.isDeviceConnectedToInternet() {
                    NoConnectionView()
                }
            })
            
            .onAppear {
                mapViewModel.initLocation()
                mapViewModel.navigateToSelectedTreeDetailView = false
            }
            
            .task {
                await mapViewModel.getTrees()
            }
            .navigationBarHidden(true)
        }
    }
}

struct ClusterMapView_Previews: PreviewProvider {
    static var previews: some View {
        ClusterMapView()
    }
}
