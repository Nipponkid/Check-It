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
    
    var rowCount = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Controller Loaded!")
        table.delegate = self
        table.dataSource = self
    }
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return rowCount
    }
    
    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        if let cell = tableView.makeView(withIdentifier: NSUserInterfaceItemIdentifier("TaskItemView"), owner: nil) as? NSTableCellView {
            if let textField = cell.textField {
                textField.stringValue = "Anything I can think of now"
            }
            return cell
        }
        return nil
    }
    
    @IBAction func closeProgram(_ sender: Any?) {
        NSApp.terminate(sender)
    }
    
    @IBAction func createTask(_ sender: Any?) {
        rowCount += 1
        table.reloadData()
    }
    
}
