//
//  HomeLeagues.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import Foundation
import UIKit

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
        LeagueRepositoryImpl.shared.getLeaguesFromNetwork(of: sport){result in
            switch result{
            case .success(let leagues):
                tableViewToBeRefreshed?.updateData(leagues: leagues)
            case .failure(let error):
                AppCommon.shared.showSimpleAlert(title: "Error", message: error.message, view: tableViewToBeRefreshed as! UIViewController)
            }
        }
    }
}
