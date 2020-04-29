//
//  DeadlineRepresentation.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation

struct DeadlineRepresentation: Codable {
    //MARK: - Enums and Type Aliases -
    enum CodingKeys: String, CodingKey {
        case name, id, studentID, notifications
        case notes = "description"
        case dueDate = "due_date"
    }
    
    
    //MARK: - Properties -
    let id: Int64
    let name: String
    var dueDate: Date
    var notes: String?
    let studentID: Int64
    var notifications: [NotificationRepresentation]
    
}
