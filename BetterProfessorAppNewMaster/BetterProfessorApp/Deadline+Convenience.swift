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
    var deadlineRepresentation: DeadlineRepresentation? {
        guard let name = name, let notes = notes, let dueDate = dueDate, let notifications = notifications else { return nil }
        var notificationsRepsArray: [NotificationRepresentation]
        
        
        for case let notification as Notification in notifications {
            
            notificationsRepsArray.append(notification.notificationRepresentation)
            }
            return DeadlineRepresentation(id: id,
                                          name: name,
                                          dueDate: dueDate,
                                          notes: notes,
                                          studentID: studentID,
                                          notifications: notificationsRepsArray)
            
        
    }
    
    //MARK: - Initializers -
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
        
        if let notes = representation.notes {
            self.init(context: context)
            self.id = representation.id
            self.name = representation.name
            self.notes = notes
            self.studentID = representation.studentID
            self.student = //fetch deadlines for studentID from coredata
            self.notifications = NSSet(array: representation.notifications)
            
        }
        
    }
}
