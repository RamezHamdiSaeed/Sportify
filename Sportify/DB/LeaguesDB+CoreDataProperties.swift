//
//  LeaguesDB+CoreDataProperties.swift
//  
//
//  Created by Ramez Hamdi Saeed on 02/05/2024.
//
//

import Foundation
import CoreData


extension LeaguesDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LeaguesDB> {
        return NSFetchRequest<LeaguesDB>(entityName: "LeaguesDB")
    }

    @NSManaged public var countryKey: Int32
    @NSManaged public var countryLogo: String?
    @NSManaged public var countryName: String?
    @NSManaged public var leagueKey: Int32
    @NSManaged public var leagueLogo: String?
    @NSManaged public var leagueName: String?
    @NSManaged public var sport: String?

}
