//
//  TaskListController.swift
//  Check-It
//
//  Created by Brandon Marella on 8/4/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Foundation

class TaskListController {
    private var uncompletedTasks: [Task] = []
    private var completedTasks: [Task] = [
        Task(title: "Testing", description: "T##String?")
    ]
    
    private func completeTask(task: Task) {
        if let index = uncompletedTasks.firstIndex(of: task) {
            let completedTask = uncompletedTasks.remove(at: index)
            completedTasks.append(completedTask)
        }
    }
    
    func completeTask(taskNumber: Int) {
        completeTask(task: uncompletedTasks[taskNumber])
    }
    
    func numCompleted() -> Int {
        return completedTasks.count
    }
    
    func numUncompleted() -> Int {
        return uncompletedTasks.count
    }
    
    func getUncompleted(taskNumber index: Int) -> Task {
        return uncompletedTasks[index]
    }
    func getCompleted(taskNumber index: Int) -> Task {
        return completedTasks[index]
    }
    
    func add(task: Task) {
        uncompletedTasks.append(task)
    }
}
