//
//  RemoteDataSourceImpl.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import Alamofire
import Foundation

class RemoteDataSourceImpl: RemoteDataSource {

    
    private static func performRequest<T: Decodable>(route: APIRouter, decoder: JSONDecoder = JSONDecoder(), completion: @escaping (Result<T, NetworkError>) -> Void) {
        guard AppCommon.shared.isNetworkReachable() else {
            completion(.failure(.networkError(message: "Oops! Something went wrong with the network. Please check your internet connection and try again.")))
            return
        }
//        print(route)
        AF.request(route).validate()
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    print(error.localizedDescription)
                    do {
                        guard let data = response.data else {
                            completion(.failure(.other))
                            return
                        }
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                        if let message = (json as? [String: Any])?["Message"] as? String {
                            completion(.failure(.networkError(message: message)))
                        } else {
                            completion(.failure(.networkError(message: error.localizedDescription)))
                        }
                    } catch {
                        completion(.failure(.networkError(message: error.localizedDescription)))
                    }
                    break
                }
            }
    }
    
    static func getLeagues(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void){
        RemoteDataSourceImpl.performRequest(route: .leagues(sport: sport), completion: completion)
    }
    
    static func getEvents(of sport: Sport, from startDate: String, to endDate: String, for leagueId: String, completion: @escaping (Result<EventsResponse, NetworkError>) -> Void) {
        RemoteDataSourceImpl.performRequest(route: .events(sport: sport, leagueId: leagueId, from: startDate, to: endDate), completion: completion)
    }
    
    static func getTeams(of sport: Sport, for leagueId: String, completion: @escaping (Result<Teams, NetworkError>) -> Void) {
        RemoteDataSourceImpl.performRequest(route: .teams(Sport: sport, leagueId: leagueId), completion: completion)
    }
    
    static func getPlayers(of sport: Sport, for teamId: String, completion: @escaping (Result<PlayerResponse, NetworkError>) -> Void) {
        RemoteDataSourceImpl.performRequest(route: .players(Sport: sport, teamId: teamId), completion: completion)
    }
    

  
}
