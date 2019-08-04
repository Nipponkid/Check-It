//
//  Task.swift
//  Check-It
//
//  Created by Brandon Marella on 6/10/19.
//  Copyright © 2019 Allegory. All rights reserved.
//

import Foundation

struct Task: Equatable {
    var title: String
    var description: String?
    var isComplete: Bool = false
    
    init(title: String, description: String?) {
        self.title = title
        self.description = description
    }
    
    static func ==(lhs: Task, rhs: Task) -> Bool {
        return (lhs.title == rhs.title) && (lhs.description == rhs.description)
    }
}
