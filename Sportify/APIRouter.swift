//
//  APIRouter.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import Foundation
import Alamofire

enum Sport {
    case tennis
    case basketball
    case cricket
    case football

    var endpoint: String {
        switch self {
        case .tennis:
            return Constants.API.Endpoints.tennis
        case .basketball:
            return Constants.API.Endpoints.basketball
        case .cricket:
            return Constants.API.Endpoints.cricket
        case .football:
            return Constants.API.Endpoints.football
        }
    }
}

enum APIRouter: URLRequestConvertible {
    case leagues(sport: Sport)
    case upcomingEvents(sport: Sport, leagueId: String, from: String, to: String)
    
    var method: HTTPMethod {
        return .get
    }
    
    var encoding: ParameterEncoding {
        return URLEncoding(destination: .queryString)
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .leagues(_):
            return ["met": "Leagues",
                    "APIkey": Constants.API.key]
        case .upcomingEvents(_, let leagueId, let from, let to):
            return [
                "met": "Fixtures",
                "APIkey": Constants.API.key,
                "leagueId": leagueId,
                "from": from,
                "to": to
            ]
        }
    }
    
    var path: String {
        switch self {
        case .leagues(let sport), .upcomingEvents(let sport, _, _, _):
            return sport.endpoint
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.API.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        return try encoding.encode(urlRequest, with: parameters)
    }
}

