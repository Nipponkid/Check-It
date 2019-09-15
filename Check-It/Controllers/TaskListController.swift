//
//  TaskListController.swift
//  Check-It
//
//  Created by Brandon Marella on 8/4/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import CoreData

class TaskListController {
    var uncompletedTasks: [Task] = []
    var completedTasks: [Task] = []
    
    init() {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            
            let objects = try persistentContainer.viewContext.fetch(fetchRequest)
            for object in objects {
                self.add(task: object as! Task)
            }
        } catch _ as NSError {
            print("Raggy, i ran't reatch it!")
        }
        
    }
    
    lazy var persistentContainer: PersistentContainer = {
        let container = PersistentContainer(name: "TaskModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        
        
        return container
    }()
    
    func completeTask(taskNumber: Int) {
        let task = uncompletedTasks[taskNumber]
        if let index = uncompletedTasks.firstIndex(of: task) {
            let completedTask = uncompletedTasks.remove(at: index)
            completedTask.isCompleted = true
            completedTasks.append(completedTask)
        }
        persistentContainer.save()
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
            persistentContainer.delete(task: task)
        }
    }
    
    func remove(completed task: Task) {
        if let index = completedTasks.firstIndex(of: task) {
            completedTasks.remove(at: index)
            persistentContainer.delete(task: task)
        }
    }
    
    func createTask(withTitle title: String, withDescription description: String) {
        let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: persistentContainer.viewContext) as! Task
        task.title = title
        task.taskDescription = description
        
        self.add(task: task)
        persistentContainer.save()
    }
    
    func clearUncompleted() {
        uncompletedTasks = []
    }
    func clearCompleted() {
        completedTasks = []
    }
}
