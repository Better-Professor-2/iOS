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
    
    func createDeadline(for student: Student, name: String, dueDate: Date, notes: String?, notifications: [Notification] = [], context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        student.addToDeadlines(Deadline(id: Int64.random(in: 1024...2048), name: name, dueDate: dueDate, notes: notes ?? "", studentID: student.id, student: student, notifications: notifications, context: context))
    }
    
    func fetchDeadline() {
        
    }
    
    func updateDeadline() {
        
    }
    
    func deleteDeadline() {
        
    }
}
