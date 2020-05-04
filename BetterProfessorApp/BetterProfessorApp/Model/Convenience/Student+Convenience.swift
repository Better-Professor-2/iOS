//
//  Student+Convenience.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

extension Student {

    // MARK: - Extended Properties 
    /// Use dot syntax to call a codable representation of a model object
    var studentRepresentation: StudentRepresentation? {
        guard let firstName = firstName,
            let lastName = lastName,
            let email = email,
            let phoneNumber = phoneNumber,
            let professor = professor,
            let deadlines = deadlines else { return nil }
        var deadlineRepsArray: [DeadlineRepresentation] = []
        for case let deadline as Deadline in deadlines {
            guard let deadlineRep = deadline.deadlineRepresentation else { return nil }
            deadlineRepsArray.append(deadlineRep)
        }
        return StudentRepresentation(id: id,
                                     firstName: firstName,
                                     lastName: lastName,
                                     email: email,
                                     phoneNumber: phoneNumber,
                                     professor: professor.professorRepresentation!,
                                     professorID: professorID,
                                     deadlines: deadlineRepsArray)
    }
    // MARK: - Initializers
    /// Use these convenience initializers to move Model objects between CoreData and the network API
    @discardableResult convenience init(id: Int64,
                                        firstName: String,
                                        lastName: String,
                                        email: String,
                                        phoneNumber: String? = "",
                                        professor: Professor,
                                        deadlines: [Deadline],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.professor = professor
        self.professorID = professor.id
        self.deadlines = NSSet(array: deadlines)
    }

    @discardableResult convenience init?(representation: StudentRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = representation.id
        self.firstName = representation.firstName
        self.lastName = representation.lastName
        self.email = representation.email
        self.phoneNumber = representation.phoneNumber
        self.professor = ProfessorController.shared.fetchProfessor(id: representation.professor.id)
        self.professorID = representation.professor.id
        self.deadlines = NSSet(array: representation.deadlines)
    }
}
