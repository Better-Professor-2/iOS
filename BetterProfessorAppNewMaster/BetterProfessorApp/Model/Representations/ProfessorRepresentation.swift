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

    //MARK: - Properties -
    let id: Int64
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    var students: [StudentRepresentation]
}
