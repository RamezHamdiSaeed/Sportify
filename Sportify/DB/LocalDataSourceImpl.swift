//
//  LocalDataSourceImpl.swift
//  Sportify
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//

import Foundation
import UIKit
import CoreData


class LocalDataSourceImpl : LocalDataSource{
    
    public static let shared = LocalDataSourceImpl()
    private var leagues = [LeaguesDB]()
    
    
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    func getLeaguesFromFav() -> [League]? {
        do{
            leagues = try context!.fetch(LeaguesDB.fetchRequest())
            return prepareData()
            
        }catch{
            print("error happened while retireving the data over the dataBase")
            return [League]()
        }
    }
    
    func insertLeagueToFav(league: League) {
        let newLeague = LeaguesDB(context: self.context!)
        newLeague.leagueKey = Int32(league.leagueKey  ?? 0)
        newLeague.leagueName = league.leagueName
        newLeague.countryKey = Int32(league.countryKey ?? 0)
        newLeague.countryName = league.countryName
        newLeague.leagueLogo = league.leagueLogo
        newLeague.countryLogo = league.countryLogo
        guard let sport = AppCommon.shared.sport else {
            return
        }
        print("sport is \(String(describing: sport))")
        newLeague.sport = String(describing: sport)
        
        do{
            try context?.save()
        }
        catch{
            print("error happened while retireving the data over the dataBase")
            
        }
    }
    
    func deleteLeagueToFav(league: League) {
        if let index = leagues.firstIndex(where: { $0.leagueKey == league.leagueKey ?? -1 }) {
            context?.delete(leagues[index])
            do {
                try context?.save()
            } catch {
                print("Error occurred while deleting data from the database")
            }
        }
    }
    
    func isFav(league: League) -> Bool {
        return leagues.contains(where: { $0.leagueKey == league.leagueKey ?? -1 })
    }
    
    
    func prepareData()->[League]{
        
        var preparedLeagues = [League]()
        
        for item in  0..<self.leagues.count{
            
            let leagueItem = League(leagueKey: Int(self.leagues[item].leagueKey), leagueName: self.leagues[item].leagueName, countryKey: Int(self.leagues[item].countryKey), countryName: self.leagues[item].countryName, leagueLogo: self.leagues[item].leagueLogo, countryLogo: self.leagues[item].countryLogo)
            
            preparedLeagues.append(leagueItem)
        }
        return preparedLeagues
    }
    
    func getLeagueSport(index: Int) {
        let leagueSport = self.leagues[index].sport
        print("sport is : \(String(describing: leagueSport))")
        guard let sportName = leagueSport else {
            return
        }
        switch sportName {
        case "tennis":
            AppCommon.shared.sport = Sport.tennis
        case "basketball":
            AppCommon.shared.sport = Sport.basketball
        case "cricket":
            AppCommon.shared.sport = Sport.cricket
        default:
            AppCommon.shared.sport = Sport.football

        }
    }
    
}
