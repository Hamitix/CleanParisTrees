//
//  Constants.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct K {
    
    struct Network {
        static let labelDQ = "InternetConnectionMonitor"
    }
    
    struct CoreData {
        static let treeContainerName = "TreeCDModel"
    }
    
    struct UserDefaults {
        static let keyFavTrees = "Favourites"
    }
    
    struct OpenDataAPI {
        static let baseURL = "https://opendata.paris.fr/"
        static let baseQuery = "api/records/1.0/search/?dataset=les-arbres&q="
        static let nbRowPerRequest = 20
        static let facet = "&facet=&facet=arrondissement&facet=libellefrancais&facet=genre&facet=espece&facet=circonferenceencm&facet=hauteurenm"
    }
    
    struct Map {
        static let longitudeDelta = 0.02
        static let latitudeDelta = 0.02
        static let latParis = 48.866667
        static let longParis = 2.333333
    }
    
    struct WeatherAPI {
        static let keyAPI = "bffc2bd3a2ab6f94b7cdfd793266b8c4"
        static let baseURL = "https://api.openweathermap.org/data/2.5/"
    }
}
