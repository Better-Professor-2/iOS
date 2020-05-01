//
//  Deadline+Convenience.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

extension Deadline {
    
    //MARK: - Extended Properties -
    /// Use dot syntax to call a codable representation of a model object
    var deadlineRepresentation: DeadlineRepresentation? {
        guard let name = name,
            let notes = notes,
            let dueDate = dueDate,
            let notifications = notifications else { return nil }
        var notificationsRepsArray: [NotificationRepresentation] = []
        for case let notification as Notification in notifications {
            guard let notificationRep = notification.notificationRepresentation else { return nil }
            notificationsRepsArray.append(notificationRep)
        }
        return DeadlineRepresentation(id: id,
                                      name: name,
                                      dueDate: dueDate,
                                      notes: notes,
                                      studentID: studentID,
                                      notifications: notificationsRepsArray)
    }
    // MARK: - Initializers
    /// Use these convenience initializers to move Model objects between CoreData and the network API
    @discardableResult convenience init(id: Int64,
                                        name: String,
                                        dueDate: Date,
                                        notes: String,
                                        studentID: Int64,
                                        student: Student,
                                        notifications: [Notification] = [],
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = id
        self.name = name
        self.notes = notes
        self.studentID = studentID
        self.student = student
        self.notifications = NSSet(array: notifications)
    }
    @discardableResult convenience init?(representation: DeadlineRepresentation,
                                         context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.id = representation.id
        self.name = representation.name
        self.notes = notes
        self.studentID = representation.studentID
        self.student = StudentController.shared.fetchStudent(id: representation.studentID)
        self.notifications = NSSet(array: representation.notifications)
    }
}
