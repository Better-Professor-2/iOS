//
//  Professor+Convenience.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

extension Professor {
    // MARK: - Extended Properties 
    /// Use dot syntax to call a codable representation of a model object
    var professorRepresentation: ProfessorRepresentation? {
        guard let password = password,
            let firstName = firstName,
            let lastName = lastName,
            let email = email,
            let students = students else { return nil }
        var studentRepsArray: [StudentRepresentation] = []
        for case let student as Student in students {
            guard let studentRep = student.studentRepresentation else { return nil }
            studentRepsArray.append(studentRep)
        }

        return ProfessorRepresentation(id: id,
                                       email: email,
                                       password: password,
                                       firstName: firstName,
                                       lastName: lastName,
                                       students: studentRepsArray)

    }
    // MARK: - Initializers
    /// Use these convenience initializers to move Model objects between CoreData and the network API
    @discardableResult convenience init(id: Int64,
                                        email: String,
                                        password: String,
                                        firstName: String,
                                        lastName: String,
                                        students: [Student],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.students = NSSet(array: students)
    }

    @discardableResult convenience init?(representation: ProfessorRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        self.id = representation.id
        self.email = representation.email
        self.password = representation.password
        self.firstName = representation.firstName
        self.lastName = representation.lastName
        self.students = NSSet(array: [representation.students])
    }
}
