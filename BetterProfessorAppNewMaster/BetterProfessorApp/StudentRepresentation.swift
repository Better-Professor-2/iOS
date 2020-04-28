//
//  StudentRepresentation.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData


struct StudentRepresentation: Codable {

    //MARK: - Enums and Type Aliases -
    enum CodingKeys: String, CodingKey {
        case id, professorID
        case professor
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case phoneNumber = "phone_number"
    }

    //MARK: - Properties -
    let id: Int64
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String?
    let professor: ProfessorRepresentation
    let professorID: Int64
}
