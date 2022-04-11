//
//  Constants.swift
//  TreeOP
//
//  Created by Dylan HAMITI on 08/04/2022.
//

import Foundation

struct K {
    static let titleApp = "Tree OP"
    static let titleMainView = "List of Trees"
    
    struct TreeItem {
        static let species = "Species : "
        static let height = "Height : "
        static let circumference = "Circumference : "
        static let adress = "Adress : "
    }
    
    struct OpenDataAPI {
        static let baseURL = "https://opendata.paris.fr/api/"
        static let query = "records/1.0/search/?dataset=les-arbres&q=&facet=typeemplacement&facet=domanialite&facet=arrondissement&facet=libellefrancais&facet=genre&facet=espece&facet=varieteoucultivar&facet=circonferenceencm&facet=hauteurenm&facet=stadedeveloppement&facet=remarquable"
        
        static let errorRetrievingData = "Couldn't retrieve data : "
        static let errorDecodingData = "Couldn't decode data : "
    }
}
