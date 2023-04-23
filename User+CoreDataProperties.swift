//
//  User+CoreDataProperties.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var username: String?
    @NSManaged public var moods: NSSet?
    
    public var wrappedDisplayName: String {
        displayName ?? "Uknown Display Name Here"
    }
    public var wrappedUsername: String {
        username ?? "Uknown Username Here"
    }
    
    public var moodsArray: [Mood] {
        let set = moods as? Set<Mood> ?? []
        
        return set.sorted {
            $0.date ?? Date() < $1.date ?? Date()
        }
    }
    
}

// MARK: Generated accessors for moods
extension User {

    @objc(addMoodsObject:)
    @NSManaged public func addToMoods(_ value: Mood)

    @objc(removeMoodsObject:)
    @NSManaged public func removeFromMoods(_ value: Mood)

    @objc(addMoods:)
    @NSManaged public func addToMoods(_ values: NSSet)

    @objc(removeMoods:)
    @NSManaged public func removeFromMoods(_ values: NSSet)

}

extension User : Identifiable {

}
