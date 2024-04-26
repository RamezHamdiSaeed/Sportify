//
//  LeagueDetailsView.swift
//  Sportify
//
//  Created by Hadir on 26/04/2024.
//

import Foundation

protocol LeagueDetailsView{
    func showUpcomingEvents(events: [Event]?)
    func showLatestEvents(events: [Event]?)
    func showTeams(teams: [Team]?)
}
