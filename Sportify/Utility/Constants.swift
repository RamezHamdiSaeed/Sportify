//
//  Constants.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import Foundation
struct Constants {
    struct API {
        static let baseURL = "https://apiv2.allsportsapi.com/"
        static let key = "706020e5383ecbcfe7ba71d76311b9cc579e701e2659d9700d1c574a3aae1b72"
        struct Endpoints{
            static let basketball = "basketball"
            static let football = "football"
            static let cricket = "cricket"
            static let tennis = "tennis"
        }
    }
}
enum HTTPHeaderField: String {
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}
