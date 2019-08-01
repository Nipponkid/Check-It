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
    
    var uncompletedTasks: [Task]
    var completedTasks: [Task]
    
    init(for tasks: [Task]) {
        self.uncompletedTasks = tasks
        self.completedTasks = []
        print(tasks)
        super.init(nibName: "NewTaskViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        self.uncompletedTasks = []
        self.completedTasks = []
        super.init(coder: aCoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func createNewTask(_ sender: Any?) {
        let temp = Task(title: titleTextField.stringValue, description: descriptionTextField.stringValue)
        if temp.title != "" {
            uncompletedTasks.append(temp)
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.popover.contentViewController = CheckitViewController(forUncompleted: uncompletedTasks, forCompleted: completedTasks)
        }
    }
    
}
