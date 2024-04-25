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
    
    func getUpcomingLeagueEvents(sport: Sport,
                                 leagueId: Int,
                                 from startDate: String,
                                 to endDate: String,
                                 completion: @escaping (Result<UpcomingEvents, NetworkError>) -> Void)
    
    func getLatestResults(sport: Sport, leagueId: Int,
                          completion: @escaping (Result<LatestResults, NetworkError>) -> Void)
    
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
    func getUpcomingLeagueEvents(sport: Sport, leagueId: Int, from startDate: String, to endDate: String, completion: @escaping (Result<UpcomingEvents, NetworkError>) -> Void) {
        
    }
    
    func getLatestResults(sport: Sport, leagueId: Int, completion: @escaping (Result<LatestResults, NetworkError>) -> Void) {
        
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
