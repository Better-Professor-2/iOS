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
        guard let id = id else { return nil }
        if let phoneNumber = phoneNumber,
            let deadlines = deadlines
        var deadlineRepsArray: [DeadlineRepresentation]
        
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


    //MARK: - Initializers -
    @discardableResult convenience init(id: Int64,
                                        firstName: String,
                                        lastName: String,
                                        email: String,
                                        phoneNumber: String?,
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
        self.deadlines = NSSet(array: deadlines)
    }

    @discardableResult convenience init?(representation: StudentRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let id = representation.id else { return nil }
        if let deadlines = representation.deadlines, phoneNumber = representation.phoneNumber
        
        
        self.init(context: context)
        self.id = id
        self.firstName = representation.firstName
        self.lastName = representation.lastName
        self.email = representation.email
        self.phoneNumber = phoneNumber
        self.professor = representation.professor
        self.deadlines = NSSet(array: deadlines)
    }

}
