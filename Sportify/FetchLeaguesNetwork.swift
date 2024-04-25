//
//  FetchLeaguesNetwork.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import Foundation

class FetchLeaguesNetwork : RemoteDataSource{
    func getLeagues(sport: Sport) -> Leagues {
        switch sport {
        case .football:
            return Leagues(success: 1,result: Array(repeating: League(league_key: "10",league_name: nil, country_key: "10", country_name: "Albania",league_logo: nil, country_logo: "https://apiv2.allsportsapi.com/logo/logo_country/10_albania.png"), count: 10))
        case .tennis:
            return Leagues(success: 1,result: Array(repeating: League(league_key: "10",league_name: nil, country_key: "10", country_name: "Albania",league_logo: nil, country_logo: "https://apiv2.allsportsapi.com/logo/logo_country/10_albania.png"), count: 10))
        case .basketball:
            return Leagues(success: 1,result: Array(repeating: League(league_key: "10",league_name: nil, country_key: "10", country_name: "Albania",league_logo: nil, country_logo: "https://apiv2.allsportsapi.com/logo/logo_country/10_albania.png"), count: 10))
        case .cricket:
            return Leagues(success: 1,result: Array(repeating: League(league_key: "10",league_name: nil, country_key: "10", country_name: "Albania",league_logo: nil, country_logo: "https://apiv2.allsportsapi.com/logo/logo_country/10_albania.png"), count: 10))
        }

    }
    
    func getLeagueInfo(league: League) -> LeagueDetails {
        //fake
        return [LeagueDetails].self as! LeagueDetails

    }
    
    func getTeamInfo(team: Team) -> TeamDetails {
        //fake
        return [TeamDetails].self as! TeamDetails
    }
    
    
}
