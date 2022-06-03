//
//  RefreshButtonView.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 03/06/2022.
//

import SwiftUI
import Resolver

struct RefreshButtonView: View {
    
    @InjectedObject var weatherInfoViewModel: WeatherInfoViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button {
                Task {
                    await weatherInfoViewModel.getAllWeatherData(forceRefresh: true)
                }
            } label: {
                Image(systemName: String(localized:"refreshArrowIcon"))
                    .padding()
                    .foregroundColor(.primary)
            }
        }
    }
}

struct RefreshButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RefreshButtonView()
    }
}
