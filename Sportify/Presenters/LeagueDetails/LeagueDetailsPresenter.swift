//
//  LeagueDetailsPresenter.swift
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


class LeagueDetailsPresenter{
   
    var view: LeagueDetailsView?
    
    func attachView(view: LeagueDetailsView){
        self.view = view
    }
    
    func getUpcomingEvents(of sport: Sport, for leagueId: String) {

        let calendar = Calendar.current
        let today = Date()
        let eightMonthsLater = calendar.date(byAdding: .month, value: 8, to: Date())!
        
        LeagueRepositoryImpl.shared.getLeagueEvents(sport: sport, leagueId: leagueId, from: getFormattedDate(date: today), to: getFormattedDate(date: eightMonthsLater)){[weak self] result in
            switch result {
            case .success(let response):
                self?.view?.showUpcomingEvents(events: response.result)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    func getLatestResults(of sport: Sport, for leagueId: String) {
        let calendar = Calendar.current
        let aDayBefore = calendar.date(byAdding: .day, value: -1, to: Date())!
        let aWeekBefore = calendar.date(byAdding: .day, value: -7, to: aDayBefore)!
        
        LeagueRepositoryImpl.shared.getLeagueEvents(sport: sport, leagueId: leagueId, from: getFormattedDate(date: aWeekBefore), to: getFormattedDate(date: aDayBefore)){[weak self] result in
            switch result {
            case .success(let response):
//                print("getLatestResults: \(response)")
                self?.view?.showLatestEvents(events: response.result)
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    func getTeams(of sport: Sport, for leagueId: String) {
        LeagueRepositoryImpl.shared.getTeams(of: sport, for: leagueId){[weak self] result in
        switch result {
        case .success(let response):
//            print("getTeams: \(response)")
            self?.view?.showTeams(teams: response.result)
        case .failure(let failure):
            print(failure.localizedDescription)
        }
        
    }
    }
    
    func getFormattedDate(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    func addToFav(league: League) {
        LeagueRepositoryImpl.shared.insertLeagueToFav(league: league)
    }
    
    func deleteFromFav(league: League) {
        LeagueRepositoryImpl.shared.deleteLeagueToFav(league: league)
    }
    
    func isFav(league: League)->Bool {
        return LeagueRepositoryImpl.shared.isFav(league: league)
    }
    
}
