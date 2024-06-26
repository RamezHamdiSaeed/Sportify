//
//  FavoriteLeagues.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import Foundation

protocol FavoriteLeaguesView{
    func updateData(leagues:[League])
}

class FavoriteLeaguesPresenter{
    static var leaguesDB : [League] = [League]()

    private static var tableViewToBeRefreshed: FavoriteLeaguesView!
    
    static func setupView(tableViewToBeRefreshed:FavoriteLeaguesView){
        self.tableViewToBeRefreshed = tableViewToBeRefreshed
    }
    static func getLeaguesFromFav() {
        self.tableViewToBeRefreshed?.updateData(leagues: LeagueRepositoryImpl.shared.getLeaguesFromFav())
//        print(LeagueRepositoryImpl.shared.getLeaguesFromFav())
    }
    static func deleteLeagueFromFav(league:League){
        LeagueRepositoryImpl.shared.deleteLeagueToFav(league: league)
        getLeaguesFromFav()
    }

    static func updateSportCategory(index:Int){
        LeagueRepositoryImpl.shared.setLeagueSportInFav(index:index)
    }
}
