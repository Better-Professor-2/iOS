//
//  ProfessorRepresentation.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

struct ProfessorRepresentation: Codable {

    // MARK: - Enums and Type Aliases
    enum CodingKeys: String, CodingKey {
        case id, email, password, students
        case firstName = "first_name"
        case lastName = "last_name"
    }

    // MARK: - Properties
    var id: Int64
    var email: String
    var password: String
    var firstName: String
    var lastName: String
    var students: [StudentRepresentation]
}
