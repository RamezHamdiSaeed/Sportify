//
//  Leagues+CoreDataProperties.swift
//  
//
//  Created by Ramez Hamdi Saeed on 25/04/2024.
//
//

import Foundation
import CoreData


extension Leagues {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Leagues> {
        return NSFetchRequest<Leagues>(entityName: "Leagues")
    }

    @NSManaged public var leagueKey: Int32
    @NSManaged public var leagueName: String?
    @NSManaged public var countryKey: Int32
    @NSManaged public var countryName: String?
    @NSManaged public var leagueLogo: String?
    @NSManaged public var countryLogo: String?

}
