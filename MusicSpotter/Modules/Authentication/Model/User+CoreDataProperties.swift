//
//  User+CoreDataProperties.swift
//  MusicSpotter
//
//  Created by IOS-Babu on 10/05/24.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?
    @NSManaged public var username: String?
    @NSManaged public var favoriteTrackIds: [String]?

}

extension User : Identifiable {

}
