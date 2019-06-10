//
//  Task.swift
//  Check-It
//
//  Created by Brandon Marella on 6/10/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Foundation

class Task {
    var title: String
    var description: String?
    var isComplete: Bool = false
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
}
