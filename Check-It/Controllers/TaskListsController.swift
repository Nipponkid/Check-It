//
//  TaskListsController.swift
//  Check-It
//
//  Created by Brandon Marella on 9/14/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import CoreData

class TaskListsController {
    var taskLists: [String: TaskListController] = [:]
    
    let container: PersistentContainer
    
    init(container: PersistentContainer) {
        self.container = container
    }
    
    func addList(withName name: String) {
        self.taskLists[name] = TaskListController()
    }
}
