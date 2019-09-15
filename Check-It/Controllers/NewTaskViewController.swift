//
//  NewTaskViewController.swift
//  Check-It
//
//  Created by Wesley Brown on 7/29/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class NewTaskViewController: NSViewController {
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    var taskController: TaskListController
    
    init(for controller: TaskListController) {
        self.taskController = controller
        super.init(nibName: "NewTaskViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        fatalError("[init?(coder)]: Has not been initialized.")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func createNewTask(_ sender: Any?) {
        if titleTextField.stringValue != "" {
            taskController.createTask(withTitle: titleTextField.stringValue, withDescription: descriptionTextField.stringValue)
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.createTabView()
        } else {
            titleTextField.backgroundColor = NSColor.red
        }
    }
    
    @IBAction func cancel(_ sender: Any?) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.createTabView()
    }
}
