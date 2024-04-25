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
    
    func getUpcomingLeagueEvents(sport: Sport,
                                 leagueId: Int,
                                 from startDate: String,
                                 to endDate: String,
                                 completion: @escaping (Result<UpcomingEvents, NetworkError>) -> Void)
    
    func getLatestResults(sport: Sport, leagueId: Int,
                          completion: @escaping (Result<LatestResults, NetworkError>) -> Void)
    
    func getLeaguesFromFav()->[League]?
    func insertLeagueToFav(league: League)
    func deleteLeagueToFav(league: League)
}

class LeagueRepositoryImpl: LeagueRepository{
    
    static let shared = LeagueRepositoryImpl()
    private init(){}
    
    func getLeaguesFromNetwork(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void){
        RemoteDataSourceImpl.getLeagues(of: sport, completion: completion)
    }
    func getUpcomingLeagueEvents(sport: Sport, leagueId: Int, from startDate: String, to endDate: String, completion: @escaping (Result<UpcomingEvents, NetworkError>) -> Void) {
        
    }
    
    func getLatestResults(sport: Sport, leagueId: Int, completion: @escaping (Result<LatestResults, NetworkError>) -> Void) {
        
    }
    
    
    func getLeaguesFromFav()->[League]? {
        return nil
    }
    
    func insertLeagueToFav(league: League) {
        
    }
    
    func deleteLeagueToFav(league: League) {
        
    }
    
    
}
