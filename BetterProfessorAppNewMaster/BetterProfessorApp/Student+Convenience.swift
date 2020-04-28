//
//  Student+Convenience.swift
//  BetterProfessorApp
//
//  Created by Lambda_School_Loaner_268 on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

extension Student {

    //MARK: - Extended Properties -
    var studentRepresentation: StudentRepresentation = {
        var deadlineRepsArray: [DeadlineRepresentation]
        if let phoneNumber = phoneNumber {
        
        for deadline in deadlines {
            append.deadlineRepsArray(deadline.DeadlineRepresentation)
        }
        
        return StudentRepresentation(id: id,
                                     firstName: firstName,
                                     lastName: lastName,
                                     email: email,
                                     phoneNumber: phoneNumber,
                                     professor: professor,
                                     deadlines: deadlineRepsArray)
        }
    }


    //MARK: - Initializers -
    @discardableResult convenience init(id: Int64,
                                        firstName: String,
                                        lastName: String,
                                        email: String,
                                        phoneNumber: String? = "",
                                        professor: Professor,
                                        deadlines: [Deadline] = [] ,
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

    @discardableResult convenience init?(representation: StudentRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
            
        if let phoneNumber = phoneNumber {
        self.init(context: context)
        self.id = representation.id
        self.firstName = representation.firstName
        self.lastName = representation.lastName
        self.email = representation.email
        self.phoneNumber = representation.phoneNumber
        self.professor = representation.professor
        self.professorID = representation.professor.id
        self.deadlines = NSSet(array: representation.deadlines)
        }
    }

}
