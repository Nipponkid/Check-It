//
//  UncompletedTasktViewController.swift
//  Check-It
//
//  Created by Brandon Marella on 6/10/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class UncompletedTaskViewController: NSViewController, NSTableViewDataSource,
                                NSTableViewDelegate {

    @IBOutlet weak var table: NSTableView!
    
    var taskListController: TaskListController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    init(for taskListController: TaskListController) {
        self.taskListController = taskListController
        super.init(nibName: "UncompleteTasktViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        fatalError("[init?(coder)]: Has not been initialized.")
    }

    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskListController.numUncompleted()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
         if let cell:TaskTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("UncompletedTodoTask"), owner: self) as? TaskTableCellView {
            if let titleField = cell.taskTitleTextField {
                titleField.stringValue = taskListController.getUncompleted(taskNumber: row).title!
            }
            if let descriptionField = cell.taskDescriptionTextField {
                descriptionField.stringValue = taskListController.getUncompleted(taskNumber: row).taskDescription!
            }
            
            return cell
        }
        return nil
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
        table.reloadData()
    }
    
    @IBAction func completeTask(_ sender: Any?) {
        let selected = table.row(for: sender as! NSView)
        taskListController.completeTask(taskNumber: selected)
        table.reloadData()
    }
    
    @IBAction func deleteTask(_ sender: Any?) {
        let selected = table.row(for: sender as! NSView)
        let task = taskListController.getUncompleted(taskNumber: selected)
        taskListController.remove(uncompleted: task)
        table.reloadData()
    }
    
    @IBAction func closeProgram(_ sender: Any?) {
        NSApp.terminate(sender)
    }
    
    @IBAction func promptForNewTask(_ sender: Any?) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.popover.contentViewController = NewTaskViewController(for: taskListController)
    }
    
}
