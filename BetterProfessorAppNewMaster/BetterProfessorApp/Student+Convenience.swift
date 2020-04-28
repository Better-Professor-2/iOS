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

    }


    //MARK: - Initializers -
    @discardableResult convenience init(id: Int64,
                                        firstName: String,
                                        lastName: String,
                                        email: String,
                                        phoneNumber: String? = nil,
                                        professor: Professor = ,
                                        deadlines: NSSet = ,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {

        self.init(context: context)
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.phoneNumber = phoneNumber
        self.professor = professor
        self.deadlines = deadlines
    }

    @discardableResult convenience init?(representation: StudentRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let deadlines = deadlines else { return nil }

        self.init(context: context)
        self.id = representation.id
        self.firstName = representation.firstName


    }

}
