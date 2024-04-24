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
}
struct League : Decodable{
    var league_key, league_name, country_key, country_name, league_logo, country_logo :String?
}
