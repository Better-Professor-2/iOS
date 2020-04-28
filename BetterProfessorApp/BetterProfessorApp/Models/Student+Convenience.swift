//
//  Student+Convenience.swift
//  Better Professor Mockups
//
//  Created by Cody Morley on 4/27/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
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
    
    @discardableResult convenience init?(studentRepresentation: StudentRepresentation, context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        guard let deadlines = deadlines else { return nil }
        
        self.init(context: context)
        self.id
        
    }
    
}
