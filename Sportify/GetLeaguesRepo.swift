//
//  GetLeaguesRepo.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import Foundation

class GetLeaguesRepo : LeagueRepository{
    
    let remoteDataSource:FetchLeaguesNetwork?
    
    init(remoteDataSource: FetchLeaguesNetwork?) {
        self.remoteDataSource = remoteDataSource
    }
    func getLeaguesNetwork(sport: Sport) -> Leagues {
        return (self.remoteDataSource?.getLeagues(sport: sport))!
    }
    
    
}
