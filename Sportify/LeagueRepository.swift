//
//  LeagueRepository.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol LeagueRepository{
    func getLeaguesNetwork(sport:Sport)->Leagues
}
