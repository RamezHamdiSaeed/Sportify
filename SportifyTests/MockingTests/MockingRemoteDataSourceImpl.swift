//
//  MockingRemoteDataSourceImpl.swift
//  SportifyTests
//
//  Created by Hadir on 30/04/2024.
//

import Foundation

//
//  MockedNetworkService.swift
//  MVVMUnitTests
//
//  Created by Ramez Hamdi Saeed on 30/04/2024.
//

import Foundation
@testable import Sportify

class MockedRemoteDataSource : RemoteDataSource{
    
    static var isError : Bool = false


    static let fakeLeagues: [String: Any] = [
        "success": 1,
        "result": [
            [
                "league_key": 766,
                "league_name": "NBA",
                "country_key": 197,
                "country_name": "USA",
            ],
            [
                "league_key": 982,
                "league_name": "BIG3 (3x3)",
                "country_key": 197,
                "country_name": "USA"
            ],
            [
                "league_key": 812,
                "league_name": "CBI",
                "country_key": 197,
                "country_name": "USA"
            ],
            [
                "league_key": 813,
                "league_name": "CIT",
                "country_key": 197,
                "country_name": "USA"
            ],
            [
                "league_key": 892,
                "league_name": "IBL",
                "country_key": 197,
                "country_name": "USA"
            ]
        ]
    ]
    
    static let fakeEvents: [String: Any] = [
        "success": 1,
        "result": [
            [
                "event_key": 41223,
                "event_date": "2022-04-21",
                "event_time": "01:00",
                "event_home_team": "Boston Celtics",
                "home_team_key": 7,
                "event_away_team": "Brooklyn Nets",
                "away_team_key": 2,
                "event_final_result": "114 - 107",
                "event_quarter": "",
                "event_status": "Finished",
                "country_name": "USA",
                "league_name": "NBA",
                "league_key": 766,
                "league_round": nil,
                "league_season": "2021/2022",
                "event_live": "0",
                "event_home_team_logo": "https://apiv2.allsportsapi.com/logo-basketball/7_boston_celtics.jpg",
                "event_away_team_logo": nil,
                "home_team_logo": "",
                "away_team_logo": "",
                "event_first_player": "",
                "first_player_key": "",
                "event_second_player": "",
                "second_player_key": "",
                "event_first_player_logo": "",
                "event_second_player_logo": ""
            ]
            // Additional events omitted for brevity
        ]
    ]
    
    static func getLeagues(of sport: Sportify.Sport, completion: @escaping (Result<Sportify.Leagues, Sportify.NetworkError>) -> Void) {
                if self.isError {
                    completion(.failure(.networkError(message: "Network Failure To Fetch Leagues Over The Network")))
                    return
                }
                do{
                    let data = try JSONSerialization.data(withJSONObject: fakeLeagues)
                    let result : Sportify.Leagues = try JSONDecoder().decode(Sportify.Leagues.self, from: data)
                    completion(.success(Sportify.Leagues(success: 1, result: result.result)))
                }
                catch let error{
                    print(error.localizedDescription)
                    completion(.failure(.networkError(message: "Error when dealing with the Fetched Data Over the Network")))

                }

    }
    
    static func getEvents(of sport: Sportify.Sport, from startDate: String, to endDate: String, for leagueId: String, completion: @escaping (Result<Sportify.EventsResponse, Sportify.NetworkError>) -> Void) {
        if self.isError {
            completion(.failure(.networkError(message: "Network Failure To Fetch Events Over The Network")))
            return
        }
        do{
            let data = try JSONSerialization.data(withJSONObject: fakeLeagues)
            let result : Sportify.EventsResponse = try JSONDecoder().decode(Sportify.EventsResponse.self, from: data)
            completion(.success(Sportify.EventsResponse(success: 1, result: result.result)))
        }
        catch{

            completion(.failure(.networkError(message: "Error when dealing with the Fetched Data Over the Network")))

        }
    }
    
    static func getTeams(of sport: Sportify.Sport, for leagueId: String, completion: @escaping (Result<Sportify.Teams, Sportify.NetworkError>) -> Void) {
        
    }
    
    static func getPlayers(of sport: Sportify.Sport, for teamId: String, completion: @escaping (Result<Sportify.PlayerResponse, Sportify.NetworkError>) -> Void) {
        
    }


}
