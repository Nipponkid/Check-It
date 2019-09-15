//
//  TaskListController.swift
//  Check-It
//
//  Created by Brandon Marella on 8/4/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Foundation

class TaskListController {
    var uncompletedTasks: [Task] = []
    var completedTasks: [Task] = []
    
    
    
    private func completeTask(task: Task) {
        if let index = uncompletedTasks.firstIndex(of: task) {
            let completedTask = uncompletedTasks.remove(at: index)
            completedTask.isCompleted = true
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
        if (!task.isCompleted) {
            uncompletedTasks.append(task)
        } else {
            completedTasks.append(task)
        }
    }
    
    func remove(uncompleted task: Task) {
        if let index = uncompletedTasks.firstIndex(of: task) {
            uncompletedTasks.remove(at: index)
        }
    }
    
    func remove(completed task: Task) {
        if let index = completedTasks.firstIndex(of: task) {
            completedTasks.remove(at: index)
        }
    }
    
    func clearUncompleted() {
        uncompletedTasks = []
    }
    func clearCompleted() {
        completedTasks = []
    }
}
