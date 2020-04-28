//
//  DeadlineRepresentation.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

class DeadlineRepresentation {
    //MARK: - Enums and Type Aliases -
    enum CodingKeys: String, CodingKey {
        case name
        case notes = "description"
        case dueDate = "due_date"
    }
    
    
    //MARK: - Properties -
    var name: String
    var dueDate: Date
    var notes: String
}
