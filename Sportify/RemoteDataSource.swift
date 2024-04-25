//
//  RemoteDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol RemoteDataSource{
    
    static func getLeagues(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void)
//    func getLeagueInfo(league: League)-> LeagueDetails
//    func getTeamInfo(team: Team)-> TeamDetails
    
}


