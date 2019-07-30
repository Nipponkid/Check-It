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
    
    var tasks: [Task] = [
        Task(title: "First Task", description: "Yes really, the first one.")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Controller Loaded!")
        table.delegate = self
        table.dataSource = self
    }
    
    // MARK: - NSTableViewDataSource
    func numberOfRows(in tableView: NSTableView) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        
        if let cell:TaskTableCellView = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TodoTask"), owner: self) as? TaskTableCellView {
            if let titleField = cell.taskTitleTextField {
                titleField.stringValue = tasks[row].title
            }
            if let descriptionField = cell.taskDescriptionTextField {
                if let descriptionRaw = tasks[row].description {
                    descriptionField.stringValue = descriptionRaw
                }
            }
            
            return cell
        }
        return nil
    }
    
    @IBAction func completeTask(_ sender: Any?) {
        let selected = table.row(for: sender as! NSView)
        print("Task \(tasks[selected].title) Complete")
        tasks[selected].isComplete = true
        tasks.remove(at: selected)
        table.reloadData()
    }
    
    @IBAction func closeProgram(_ sender: Any?) {
        NSApp.terminate(sender)
    }
    
    @IBAction func createTask(_ sender: Any?) {
        let temp = Task(title: "Testing Me! : \(tasks.count)", description: "This is a test thing")
        
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.popover.contentViewController = NewTaskViewController()
        
        tasks.append(temp);
        table.reloadData()
    }
    
}
