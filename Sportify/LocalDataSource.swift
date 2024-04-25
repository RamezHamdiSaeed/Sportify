//
//  LocalDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LocalDataSource{
    
    func getLeagues()->[League]
    func insertLeague(league: League)
    func deleteLeague(league: League)
    
}
