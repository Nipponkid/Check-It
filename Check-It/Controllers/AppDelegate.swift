//
//  AppDelegate.swift
//  Check-It
//
//  Created by Wesley Brown on 6/3/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    let popover = NSPopover()
    let taskListController: TaskListController = TaskListController()
    // Temporary placeholder for getting the height of the tabs in the TabViewController
    let TAB_BAR_SIZE: CGFloat = 27
    
    var tasks: [NSManagedObject] = []

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("Light"))
            button.action = #selector(toggleMenuBarWindow(_:))
        }
        createTabView()
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func saveTask() {
        let context = self.persistentContainer.viewContext
        do {
            try context.save()
        } catch _ as NSError {
            print("Error saving tasks")
        }
    }
    
    @objc func toggleMenuBarWindow(_ sender: Any?) {
        if let button = statusItem.button {
            if (popover.isShown) {
                popover.performClose(sender)
            } else {
                popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
            }
        }
    }
    
    func createTabView() {
        let tabViewController = NSTabViewController()
        let completedTaskViewController = CompletedTaskViewController(with: taskListController)
        let uncompletedTaskViewController = UncompletedTaskViewController(with: taskListController)
        
        tabViewController.addChild(uncompletedTaskViewController)
        tabViewController.addChild(completedTaskViewController)
        
        tabViewController.tabViewItem(for: completedTaskViewController)?.label = "Completed"
        tabViewController.tabViewItem(for: uncompletedTaskViewController)?.label = "Uncompleted"
        tabViewController.view.frame.size.width = completedTaskViewController.view.frame.size.width
        tabViewController.view.frame.size.height = completedTaskViewController.view.frame.size.height + TAB_BAR_SIZE
        
        popover.contentViewController = tabViewController
        popover.behavior = NSPopover.Behavior.transient
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

