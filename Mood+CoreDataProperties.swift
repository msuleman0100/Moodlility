//
//  Mood+CoreDataProperties.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/23/23.
//
//

import Foundation
import CoreData


extension Mood {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Mood> {
        return NSFetchRequest<Mood>(entityName: "Mood")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var mood: String?
    @NSManaged public var user: User?
    
    public var wrappedMood: String {
        mood ?? "Unknown Mood Here"
    }
    
    public var wrappedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        let date = formatter.string(from: date ?? Date())
//        print("\nDate -> \(self.date)")
        return date
    }

}

extension Mood : Identifiable {

}
