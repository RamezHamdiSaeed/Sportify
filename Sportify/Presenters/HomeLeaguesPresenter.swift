//
//  HomeLeagues.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import Foundation

protocol HomeLeaguesView{
    func updateData(leagues:Leagues)
}

class HomeLeaguesPresenter{
    private static var tableViewToBeRefreshed: HomeLeaguesView!
    
    static func getLeaguesFromNetwork(of sport: Sport,tableViewToBeRefreshed:HomeLeaguesView) {
        self.tableViewToBeRefreshed = tableViewToBeRefreshed
        getLeagues(of: sport)
    }
    private static func getLeagues(of sport: Sport){
        print("getting the leagues...")
        LeagueRepositoryImpl.shared.getLeaguesFromNetwork(of: sport){result in
            switch result{
            case .success(let leagues):
                //your logic goes here
                tableViewToBeRefreshed?.updateData(leagues: leagues)
                    print(leagues)
            case .failure(let error):
                //error handling here
                print(error)
            }
        }
    }
}
