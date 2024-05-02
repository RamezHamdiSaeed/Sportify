//
//  RemoteDataSource.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol RemoteDataSource{
    
    static func getLeagues(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void)
    static func getEvents(of sport: Sport, from startDate: String, to endDate: String, for leagueId: String, completion: @escaping (Result<EventsResponse, NetworkError>) -> Void)
    static func getTeams(of sport: Sport, for leagueId: String, completion: @escaping (Result<Teams, NetworkError>) -> Void)
    static func getPlayers(of sport: Sport, for teamId: String, completion: @escaping (Result<PlayerResponse, NetworkError>) -> Void)
}

