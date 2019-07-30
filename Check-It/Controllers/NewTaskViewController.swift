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
    
    var tasks: [Task]
    
    init(for tasks: [Task]) {
        self.tasks = tasks
        print(tasks)
        super.init(nibName: "NewTaskViewController", bundle: nil)
    }
    
    required init?(coder aCoder: NSCoder) {
        self.tasks = []
        super.init(coder: aCoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    @IBAction func createNewTask(_ sender: Any?) {
        let temp = Task(title: titleTextField.stringValue, description: descriptionTextField.stringValue)
        if temp.title != "" {
            tasks.append(temp)
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.popover.contentViewController = CheckitViewController(for: tasks)
        }
    }
    
}
