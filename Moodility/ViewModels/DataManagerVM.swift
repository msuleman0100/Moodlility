//
//  DataManagerVM.swift
//  Moodility
//
//  Created by Muhammad Suleman on 4/21/23.
//

import CoreData
import Foundation

final class PersistenceVM: ObservableObject {
    
    let container = NSPersistentContainer(name: "MoodsModel")
    
    init()  {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core data failed to load: \(error.localizedDescription)")
            }
        }
        
        self.container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
    }
    
}
