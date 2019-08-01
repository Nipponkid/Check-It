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
    
    var uncompletedTasks: [Task] = [
        Task(title: "First Task", description: "Yes really, the first one.")
    ]
    
    var completedTasks: [Task] = []

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(toggleMenuBarWindow(_:))
        }
        popover.contentViewController = CheckitViewController(for: uncompletedTasks)
        popover.behavior = NSPopover.Behavior.transient;
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
    
    @objc func displayTodoItems(_ sender: Any?) {
        print("DISPLAYING!")
    }

    func constructMenu() {
        let menu = NSMenu()
        
        menu.addItem(NSMenuItem(title: "Show All To-Do Items", action: #selector(AppDelegate.displayTodoItems(_:)), keyEquivalent: "w"))
        menu.addItem(NSMenuItem(title: "Quit Application", action: #selector(NSApplication.terminate(_:)), keyEquivalent: "q"))
        
        statusItem.menu = menu
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

