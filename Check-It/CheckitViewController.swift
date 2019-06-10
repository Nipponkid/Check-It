//
//  CheckitViewController.swift
//  Check-It
//
//  Created by Brandon Marella on 6/10/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Cocoa

class CheckitViewController: NSViewController {

    @IBOutlet weak var button: NSButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("View Controller Loaded!")
    }
    
    @IBAction func closeProgram(_ sender: Any?) {
        NSApp.terminate(sender)
    }
    
}
