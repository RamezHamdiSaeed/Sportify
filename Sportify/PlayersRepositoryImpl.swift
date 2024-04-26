//
//  PlayersRepository.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 26/04/2024.
//

import Foundation



class TeamRepositoryImpl : TeamRepository{

    
    static let shared = TeamRepositoryImpl()
    private init(){}

    func getTeamInfo(of sport: Sport, for teamId: String, completion: @escaping (Result<PlayerResponse, NetworkError>) -> Void) {
        RemoteDataSourceImpl.getPlayers(of: sport, for: teamId, completion: completion)
    }
    
}
