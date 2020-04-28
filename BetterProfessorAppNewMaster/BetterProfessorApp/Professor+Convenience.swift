//
//  Professor+Convenience.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

extension Professor {
    //MARK: - Extended Properties -
    var professorRepresentation: ProfessorRepresentation? = {
        guard let students = students else {return nil}
        var studentRepsArray: [StudentRepresentation] = []

        for student in students {
            append.studentRepsArray(student.studentRepresentation)
        }

        return ProfessorRepresentation(id: id,
                                       email: email,
                                       password: password,
                                       firstName: firstName,
                                       lastName: lastName,
                                       students: studentRepsArray)

    }


    //MARK: - Initializers -
    @discardableResult convenience init(id: Int64,
                                        email: String,
                                        password: String,
                                        firstName: String,
                                        lastName: String,
                                        students: [Student] = [],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.email = email
        self.password = password
        self.firstName = firstName
        self.lastName = lastName
        self.students = NSSet(array: students)
    }

    @discardableResult convenience init?(representation: ProfessorRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let students = students else { return nil }


        self.init(context: context)
        self.id = representation.id
        self.email = representation.email
        self.password = representation.password
        self.firstName = representation.firstName
        self.lastName = representation.lastName
        self.students = NSSet(array: [students])
    }
}
