//
//  StudentController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class StudentController {
    //MARK: - Core Data Functions -
    // Use these functions in the app to handle background logic on the Student model object
    func createStudent(for professor: Professor,
                       firstName: String,
                       lastName: String,
                       email: String,
                       phoneNumber: String?,
                       context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        
        professor.addToStudents(Student(id: Int64.random(in: 256...512),
                                        firstName: firstName,
                                        lastName: lastName,
                                        email: email,
                                        phoneNumber: phoneNumber,
                                        professor: professor,
                                        deadlines: [],
                                        context: context))
        
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error - Error saving new core data entity: \(error) \(error.localizedDescription)")
        }
    }
    
    
    func fetchStudent(context: NSManagedObjectContext = CoreDataStack.shared.mainContext, id: Int64) -> Student? {
        let currentContext = context
        let studentFetch: NSFetchRequest<NSFetchRequestResult> = Student.fetchRequest()
        studentFetch.predicate = NSPredicate(format: "id == %d", id)
        
        do{
            let fetchedStudents = try currentContext.fetch(studentFetch) as? [Student]
            if let fetchedStudents = fetchedStudents {
                return fetchedStudents.first
            }
        } catch {
            NSLog("Error - Failed to fetch student objects from core data: \(error) \(error.localizedDescription)")
        }
    }
    
    
    func updateStudent(student: Student, representation: StudentRepresentation) {
        if student.id == representation.id  {
            student.email = representation.email
            student.phoneNumber = representation.phoneNumber
            student.deadlines = NSSet(array: representation.deadlines)
        }
        CoreDataStack.shared.saveToCoreData(context: CoreDataStack.shared.container.newBackgroundContext())
    }
    
    
    func deleteStudent(student: Student) {
        let moc = CoreDataStack.shared.mainContext
        guard let studentToDelete = fetchStudent(id: student.id) else { return }
        
        do {
            moc.delete(studentToDelete)
            try moc.save()
        } catch {
            NSLog("Error - Could not delete student, " + String(describing: student.firstName) + " " + String(describing: student.lastName) + " \(error) \(error.localizedDescription)")
        }
    }
}


