//
//  DeadlineController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class DeadlineController {
    //MARK: - Core Data Functions -
    // Use these functions in the app to handle background logic on the Deadline model object
    func createDeadline(for student: Student,
                        name: String,
                        dueDate: Date,
                        notes: String?,
                        notifications: [Notification] = [],
                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        student.addToDeadlines(Deadline(id: Int64.random(in: 1024...2048),
                                        name: name,
                                        dueDate: dueDate,
                                        notes: notes ?? "",
                                        studentID: student.id,
                                        student: student,
                                        notifications: notifications,
                                        context: context))
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error - Error saving new core data entity: \(error) \(error.localizedDescription)")
        }
    }
    
    
    func fetchDeadline(context: NSManagedObjectContext = CoreDataStack.shared.mainContext, id: Int64) -> Deadline? {
        let currentContext = context
        let deadlineFetch: NSFetchRequest<NSFetchRequestResult> = Deadline.fetchRequest()
        deadlineFetch.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let fetchedDeadlines = try currentContext.fetch(deadlineFetch) as? [Deadline]
            if let fetchedDeadlines = fetchedDeadlines {
                return fetchedDeadlines.first
            }
        } catch {
            NSLog("Error - Failed to fetch deadline objects from core data: \(error) \(error.localizedDescription)")
        }
    }
    
    
    func updateDeadline(deadline: Deadline, representation: DeadlineRepresentation) {
        if deadline.id == representation.id {
            deadline.name = representation.name
            deadline.dueDate = representation.dueDate
            deadline.notes = representation.notes
            deadline.notifications = NSSet(array: representation.notifications)
        }
        CoreDataStack.shared.saveToCoreData(context: CoreDataStack.shared.container.newBackgroundContext())
    }
    
    
    func deleteDeadline(deadline: Deadline) {
        let moc = CoreDataStack.shared.mainContext
        guard let deadlineToDelete = fetchDeadline(id: deadline.id) else { return }
        
        do {
            moc.delete(deadlineToDelete)
            try moc.save()
        } catch {
            NSLog("Error - Could not delete deadline, " + String(describing: deadlineToDelete.name) + " \(error) \(error.localizedDescription)")
        }
    }
}
