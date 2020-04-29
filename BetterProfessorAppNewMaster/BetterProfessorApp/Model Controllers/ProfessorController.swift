//
//  ProfessorController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class ProfessorController {
    //MARK: - Properties -
    // Fetched Results Controller - This will handle core data fetches for Professor model objects.
    
    
    
    
    //MARK: - Core Data Functions -
    // Use these functions in the app to handle background logic on the Professor Model object
    
    func createProfessor() {
        
    }
    
    func fetchProfessor() {
        
    }
    
    func updateProfessor(professor: Professor, representation: ProfessorRepresentation) {
        ///call this function to change user info or update students from a new server-side representation.
        
        professor.email = representation.email
        professor.password = representation.password
        professor.students = NSSet(array: representation.students)
        
    }
    
    func saveProfessor() {
        
    }
    
    func deleteProfessor() {
        
    }
}
