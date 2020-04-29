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
    //MARK: - Core Data Functions -
    /// Use these functions in the app to handle background logic on the Professor Model object
    
    func fetchProfessor(context: NSManagedObjectContext = CoreDataStack.shared.mainContext, id: Int64) -> Professor? {
        /// this function will fetch a Professor model object from core data using it's professorID
        let currentContext = context
        let professorFetch: NSFetchRequest<NSFetchRequestResult> = Professor.fetchRequest()
        professorFetch.predicate = NSPredicate(format: "id == %d", id)
        do {
            let fetchedProfessors = try currentContext.fetch(professorFetch) as? [Professor]
            if let fetchedProfessors = fetchedProfessors {
                return fetchedProfessors.first
            }
        } catch {
            NSLog("Error - Failed to fetch professor objects from core data: \(error) \(error.localizedDescription)")
        }
    }
    
    func updateProfessor(professor: Professor, representation: ProfessorRepresentation) {
        ///call this function to change user info or update students from a new server-side representation.
        if professor.id == representation.id {
            
            professor.email = representation.email
            professor.password = representation.password
            professor.students = NSSet(array: representation.students)
        }
        CoreDataStack.shared.saveToCoreData(context: CoreDataStack.shared.container.newBackgroundContext())
    }
    
    func deleteProfessor(professor: Professor) {
        /// call this function at log out to clear core data for a different professor user.
        let moc = CoreDataStack.shared.mainContext
        
        guard let professorToDelete = fetchProfessor(id: professor.id) else { return }
        
        do {
            moc.delete(professorToDelete)
            try moc.save()
        } catch {
            NSLog("Error - Could not delete professor, \(professor): \(error) \(error.localizedDescription)")
        }
    }
}
