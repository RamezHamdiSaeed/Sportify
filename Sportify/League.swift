//
//  League.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

struct Leagues : Decodable{
    var success:Int?
    var result:[League]?
    init(success: Int? = nil, result: [League]? = nil) {
        self.success = success
        self.result = result
    }
}
struct League : Decodable{
    
    var league_key, league_name, country_key, country_name, league_logo, country_logo :String?
    
    init(league_key: String? = nil, league_name: String? = nil, country_key: String? = nil, country_name: String? = nil, league_logo: String? = nil, country_logo: String? = nil) {
        self.league_key = league_key
        self.league_name = league_name
        self.country_key = country_key
        self.country_name = country_name
        self.league_logo = league_logo
        self.country_logo = country_logo
    }
}
