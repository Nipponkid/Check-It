//
//  NewTaskViewController.swift
//  Check-It
//
//  Created by Wesley Brown on 7/29/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class NewTaskViewController: NSViewController {
    
    var container: PersistentContainer
    
    @IBOutlet weak var titleTextField: NSTextField!
    @IBOutlet weak var descriptionTextField: NSTextField!
    
    var taskController: TaskListController
    
    init(for controller: TaskListController, with container: PersistentContainer) {
        self.taskController = controller
        self.container = container
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
            let task = NSEntityDescription.insertNewObject(forEntityName: "Task", into: container.viewContext) as! Task
            task.title = titleTextField.stringValue
            task.taskDescription = descriptionTextField.stringValue
            
            taskController.add(task: task)
            
            let appDelegate = NSApplication.shared.delegate as! AppDelegate
            appDelegate.createTabView()
            container.save()
        }
    }
    
    @IBAction func cancel(_ sender: Any?) {
        let appDelegate = NSApplication.shared.delegate as! AppDelegate
        appDelegate.createTabView()
    }
}
