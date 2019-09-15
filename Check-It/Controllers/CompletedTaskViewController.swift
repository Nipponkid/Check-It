//
//  CompletedTaskController.swift
//  Check-It
//
//  Created by Brandon Marella on 8/4/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class CompletedTaskViewController: NSViewController, NSTableViewDataSource,
                                NSTableViewDelegate {
    
    var container: PersistentContainer

    @IBOutlet weak var table: NSTableView!
    
    let taskListController: TaskListController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    init(for taskListController: TaskListController, with container: PersistentContainer) {
        self.taskListController = taskListController
        self.container = container
        super.init(nibName: "CompletedTaskViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        fatalError("[init?(coder)]: Has not been initialized.")
    }
    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskListController.numCompleted()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell:TaskTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("CompletedTodoTask"), owner: self) as? TaskTableCellView {
            if let titleField = cell.taskTitleTextField {
                titleField.stringValue = taskListController.getCompleted(taskNumber: row).title!
            }
            if let descriptionField = cell.taskDescriptionTextField {
                descriptionField.stringValue = taskListController.getCompleted(taskNumber: row).taskDescription!
            }
            
            return cell
        }
        return nil
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Task")
        
        do {
            taskListController.clearCompleted()
            
            let objects = try container.viewContext.fetch(fetchRequest)
            for object in objects {
                print("\(object.value(forKey: "title")!) - \(object.value(forKey: "taskDescription")!)")
                taskListController.add(task: object as! Task)
            }
        } catch _ as NSError {
            print("Raggy, i ran't reatch it!")
        }
        
        table.reloadData()
    }
    
    @IBAction func closeProgram(_ sender: Any?) {
        NSApp.terminate(sender)
    }
    
    @IBAction func deleteTask(_ sender: Any?) {
        let selected = table.row(for: sender as! NSView)
        let task = taskListController.getCompleted(taskNumber: selected)
        taskListController.remove(completed: task)
        table.reloadData()
    }
    
    @IBAction func promptForNewTask(_ sender: Any?) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.popover.contentViewController = NewTaskViewController(for: taskListController, with: container)
    }
    
}
