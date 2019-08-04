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

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if let button = statusItem.button {
            button.image = NSImage(named:NSImage.Name("StatusBarButtonImage"))
            button.action = #selector(toggleMenuBarWindow(_:))
        }
        popover.contentViewController = CheckitViewController(with: taskListController)
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
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

