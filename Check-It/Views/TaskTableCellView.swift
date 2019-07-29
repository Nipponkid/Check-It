//
//  TaskTableCellView.swift
//  Check-It
//
//  Created by Brandon Marella on 6/28/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class TaskTableCellView: NSTableCellView {
    
    @IBOutlet weak var taskCellView: NSView!
    @IBOutlet weak var taskTitleTextField: NSTextField!
    @IBOutlet weak var taskDescriptionTextField: NSTextField!
    
    var taskTitle: String {
        return taskTitleTextField.stringValue
    }
    var taskDescription: String {
        return taskDescriptionTextField.stringValue
    }
}
