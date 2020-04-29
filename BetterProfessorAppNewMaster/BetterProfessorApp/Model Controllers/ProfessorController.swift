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
    //MARK: - Type Aliases and Enums -
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
    }
    
    enum NetworkError: Error {
        case noProfessor
        case otherError
        case noData
        case noDecode
        case noEncode
    }
    
    typealias CompletionHandler = (Result<Bool, NetworkError>) -> Void
    
    
    //MARK: - Core Data Functions -
    /// Use these functions in the app to handle background logic on the Professor Model object
    
    func fetchProfessor(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        /// this function will fetch a Professor model object from core data using it's professorID
        let currentContext = context
        let professorFetch: NSFetchRequest<NSFetchRequestResult> = Professor.fetchRequest()
        do {
            let fetchedProfessors = try currentContext.fetch(professorFetch) as? [Professor]
        } catch {
            NSLog("Error - Failed to fetch professor objects from core data: \(error) \(error.localizedDescription).")
        }
    }
    
    func updateProfessor(professor: Professor, representation: ProfessorRepresentation) {
        ///call this function to change user info or update students from a new server-side representation.
        
        professor.email = representation.email
        professor.password = representation.password
        professor.students = NSSet(array: representation.students)
        
    }
    
    func deleteProfessor(professor: Professor) {
        /// call this function at log out to clear core data for a different professor user.
        let moc = CoreDataStack.shared.mainContext
        
        do {
            try moc.delete(professor)
        } catch {
            NSLog("Error - Could not delete professor, \(professor): \(error) \(error.localizedDescription)")
        }
    }
}
