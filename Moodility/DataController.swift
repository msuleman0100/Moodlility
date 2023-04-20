//
//  PersistenceVM.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/20/23.
//

import CoreData
import Foundation

final class DataController: ObservableObject {
    
    let container = NSPersistentContainer(name: "Bookworn")
    
    init()  {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
    }
    
    
    
}
