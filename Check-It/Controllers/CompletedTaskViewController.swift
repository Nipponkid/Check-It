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

    @IBOutlet weak var table: NSTableView!
    
    let taskListController: TaskListController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
    }
    
    init(with: TaskListController) {
        self.taskListController = with
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
                titleField.stringValue = taskListController.getCompleted(taskNumber: row).title
            }
            if let descriptionField = cell.taskDescriptionTextField {
                if let descriptionRaw = taskListController.getCompleted(taskNumber: row).description {
                    descriptionField.stringValue = descriptionRaw
                }
            }
            
            return cell
        }
        return nil
    }
    
    override func viewWillAppear() {
        super.viewWillAppear()
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
        appDelegate.popover.contentViewController = NewTaskViewController(for: taskListController)
    }
    
}
