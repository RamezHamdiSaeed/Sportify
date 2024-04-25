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
        static let key = "aea3595100a30d43a3bbfd7708bcb7a11cf0ee733f2dbef49bfb745713627689"
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
