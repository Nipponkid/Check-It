//
//  PersistentContainer.swift
//  Check-It
//
//  Created by Wesley Brown on 9/7/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import CoreData

class PersistentContainer : NSPersistentContainer {
    
    func save() {
        guard viewContext.hasChanges else { return }
        
        do {
            try viewContext.save()
        } catch let error as NSError {
            print("Error: \(error), \(error.userInfo)")
        }
    }
    
    func delete(task: Task) {
        viewContext.delete(task)
        save()  // Deletions will not persist unless saved
    }
    
}
