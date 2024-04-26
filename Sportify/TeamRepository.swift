//
//  Repository.swift
//  Sportify
//
//  Created by Hadir on 22/04/2024.
//

import Foundation

protocol TeamRepository{

    func getTeamInfo(of sport: Sport,
                         for teamId: String,
                         completion: @escaping (Result<PlayerResponse, NetworkError>) -> Void)
}
