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
        AF.request(route).validate()
            .responseDecodable { (response: AFDataResponse<T>) in
                switch response.result {
                case .success(let model):
                    completion(.success(model))
                    break
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                    break
                }
            }
    }
    
    static func getLeagues(of sport: Sport, completion: @escaping (Result<Leagues, NetworkError>) -> Void){
        RemoteDataSourceImpl.performRequest(route: .leagues(sport: sport), completion: completion)
    }
//    static func getBasketUpcomingEvents(for leagueId: String, from startDate: String, to endDate: String, completion: @escaping (Result<BasketballUpcomingEvents, NetworkError>) -> Void){
//        RemoteDataSourceImpl.performRequest(route: .upcomingEvents(sport: .basketball, leagueId: leagueId, from: startDate, to: endDate), completion: completion)
//    }
  
}
