//
//  LocalDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LocalDataSource{
    
    func getLeaguesFromFav()->[League]?
    func insertLeagueToFav(league: League)
    func isFav(league: League)->Bool
    func deleteLeagueToFav(league: League)

    
}
