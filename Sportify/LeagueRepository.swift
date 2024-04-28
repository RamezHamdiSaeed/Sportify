//
//  LeagueRepository.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LeagueRepository{
    
    func getLeaguesFromNetwork(of sport: Sport,
                               completion: @escaping (Result<Leagues, NetworkError>) -> Void)
    
    func getLeagueEvents(sport: Sport,
                         leagueId: String,
                         from startDate: String,
                         to endDate: String,
                         completion: @escaping (Result<EventsResponse, NetworkError>) -> Void)
    
    func getTeams(of sport: Sport,
                  for leagueId: String,
                  completion: @escaping (Result<Teams, NetworkError>) -> Void)
    
    func getLeaguesFromFav()->[League]
    func insertLeagueToFav(league: League)
    func deleteLeagueToFav(league: League)
    func isFav(league: League) -> Bool
}

class LeagueRepositoryImpl: LeagueRepository{
    
    static let shared = LeagueRepositoryImpl()
    private init(){}
    
    func getLeaguesFromNetwork(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void){
        RemoteDataSourceImpl.getLeagues(of: sport, completion: completion)
    }
    func getLeagueEvents(sport: Sport, leagueId: String, from startDate: String, to endDate: String, completion: @escaping (Result<EventsResponse, NetworkError>) -> Void) {
        RemoteDataSourceImpl.getEvents(of: sport, from: startDate, to: endDate, for: String(leagueId), completion: completion)
    }
    func getTeams(of sport: Sport,
                  for leagueId: String,
                  completion: @escaping (Result<Teams, NetworkError>) -> Void){
        
        RemoteDataSourceImpl.getTeams(of: sport, for: leagueId, completion: completion)
    }
    
    
    
    func getLeaguesFromFav()->[League] {
        LocalDataSourceImpl.shared.getLeaguesFromFav() ?? [League]()
    }
    
    func insertLeagueToFav(league: League) {
        LocalDataSourceImpl.shared.insertLeagueToFav(league: league)
        self.getLeaguesFromFav()
    }
    
    func deleteLeagueToFav(league: League) {
        LocalDataSourceImpl.shared.deleteLeagueToFav(league: league)
        
    }
    
    func isFav(league: League) -> Bool{
        return LocalDataSourceImpl.shared.isFav(league: league)
    }
    
    
}
