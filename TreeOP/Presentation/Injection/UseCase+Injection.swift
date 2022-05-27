//
//  UseCase+Injection.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 25/05/2022.
//

import Foundation
import Resolver

extension Resolver {
    public static func registerUseCases() {
        register { GetTreeListUseCase()  }.implements(GetTreeList.self).scope(.application)
        
        register { GetWeatherUseCase() }.implements(GetWeather.self).scope(.application)
        
        register { GetAirQualityUseCase() }.implements(GetAirQuality.self).scope(.application)
    }
}
