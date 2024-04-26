//
//  Teams.swift
//  Sportify
//
//  Created by Hadir on 25/04/2024.
//

import Foundation

// MARK: - Teams
struct Teams: Codable {
    let success: Int?
    let result: [Team]?
}

// MARK: - Team
struct Team: Codable {
    let teamKey: Int?
    let teamName: String?
    let teamLogo: String?


    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
    }
}
