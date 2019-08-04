//
//  CheckitViewController.swift
//  Check-It
//
//  Created by Brandon Marella on 6/10/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class CheckitViewController: NSViewController, NSTableViewDataSource,
                                NSTableViewDelegate {

    @IBOutlet weak var button: NSButton!
    @IBOutlet weak var list: NSTableColumn!
    @IBOutlet weak var table: NSTableView!
    
    var taskListController: TaskListController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Controller Loaded!")
        table.delegate = self
        table.dataSource = self
    }
    
    init(with taskListController: TaskListController) {
        self.taskListController = taskListController
        super.init(nibName: "CheckitViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        fatalError("[init?(coder)]: Has not been initialized.")
    }

    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return taskListController.numUncompleted()
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell:TaskTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TodoTask"), owner: self) as? TaskTableCellView {
            if let titleField = cell.taskTitleTextField {
                titleField.stringValue = taskListController.getUncomplted(taskNumber: row).title
            }
            if let descriptionField = cell.taskDescriptionTextField {
                if let descriptionRaw = taskListController.getUncomplted(taskNumber: row).description {
                    descriptionField.stringValue = descriptionRaw
                }
            }
            
            return cell
        }
        return nil
    }
    
    @IBAction func completeTask(_ sender: Any?) {
        let selected = table.row(for: sender as! NSView)
        print("Task \(taskListController.getUncomplted(taskNumber: selected).title) Complete")
        taskListController.completeTask(taskNumber: selected)
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
