//
//  RemoteDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol RemoteDataSource{
    
    func getLeagues(sport: Sport)->[League]
    func getLeagueInfo(league: League)-> LeagueDetails
    func getTeamInfo(team: Team)-> TeamDetails
    
}


enum Sport{
    case tennis
    case basketball
    case cricket
    case football
}
