//
//  Constants.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct K {
    
    static let latParis = 48.866667
    static let longParis = 2.333333
    
    struct OpenDataAPI {
        static let baseURL = "https://opendata.paris.fr/api/"
        static let query = "records/1.0/search/?dataset=les-arbres&q=&facet=typeemplacement&facet=domanialite&facet=arrondissement&facet=libellefrancais&facet=genre&facet=espece&facet=varieteoucultivar&facet=circonferenceencm&facet=hauteurenm&facet=stadedeveloppement&facet=remarquable"

    }
    
    struct Map {
        static let longitudeDelta = 0.02
        static let latitudeDelta = 0.02
    }
    
    struct WeatherAPI {
        static let keyAPI = "bffc2bd3a2ab6f94b7cdfd793266b8c4"
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
        
    }
    
    struct AirQualityAPI {
        static let keyAPI = "c47c022620c3fc85f4642636722b98d50d065e30"
        static let baseURL = "https://api.waqi.info/feed/geo:"
    }
}
