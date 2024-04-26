//
//  LeagueRepository.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol TableViewsRefresherDB{
    func updateData(leagues:[League])
}


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
    
    func getLeaguesFromFav()
    func insertLeagueToFav(league: League)
    func deleteLeagueToFav(league: League)
}

class LeagueRepositoryImpl: LeagueRepository{
    
    private var tableViewToBeRefreshed: TableViewsRefresherDB? = nil
    static let shared = LeagueRepositoryImpl()
    private init(){}
    
    func setupViewToBeUpdated(tableViewToBeRefreshed:TableViewsRefresherDB){
        self.tableViewToBeRefreshed = tableViewToBeRefreshed
    }
    
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
    
    
    
    func getLeaguesFromFav() {
        self.tableViewToBeRefreshed?.updateData(leagues: LocalDataSourceImpl.shared.getLeaguesFromFav()!)
    }
    
    func insertLeagueToFav(league: League) {
        LocalDataSourceImpl.shared.insertLeagueToFav(league: league)
        self.getLeaguesFromFav()
    }
    
    func deleteLeagueToFav(league: League) {
        
    }
    
    
}
