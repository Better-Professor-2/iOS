//
//  NotificationController.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class NotificationController {
    // Mark: - Singleton Accessor
    static let shared = NotificationController()
    // MARK: - Core Data Functions
    /// Use these functions in the app to handle background logic on the Notification model object
    func createNotification(for deadline: Deadline,
                            message: String,
                            notifyTime: Date) {
        deadline.addToNotifications(Notification(id: Int64.random(in: 4096...9999),
                                                 message: message,
                                                 notifyTime: notifyTime,
                                                 deadlineID: deadline.id,
                                                 context: CoreDataStack.shared.mainContext))
        do {
            try CoreDataStack.shared.mainContext.save()
        } catch {
            NSLog("Error - Error saving new core data entity: \(error) \(error.localizedDescription)")
        }
    }
    /// This function will fetch a Deadlinemodel object from core data using it's id
    func fetchNotification(context: NSManagedObjectContext = CoreDataStack.shared.mainContext,
                           id: Int64) -> Notification? {
        var returnedNotification: Notification? = nil
        let currentContext = context
        let notificationFetch: NSFetchRequest<NSFetchRequestResult> = Notification.fetchRequest()
        notificationFetch.predicate = NSPredicate(format: "id == %d",
                                                  id)
        let fetchedNotifications = try? currentContext.fetch(notificationFetch) as? [Notification]
        returnedNotification = fetchedNotifications?.first
        if returnedNotification == nil {
            NSLog("Error - failed to fetch notification objects from core data.")
        }
        return returnedNotification
    }
    func updateNotification(notification: Notification, representation: NotificationRepresentation) {
        notification.id = representation.id
        notification.message = representation.message
        notification.notifyTime = representation.notifyTime
        CoreDataStack.shared.saveToCoreData(context: CoreDataStack.shared.container.newBackgroundContext())
    }
    func deleteNotification(notification: Notification) {
        let moc = CoreDataStack.shared.mainContext
        guard let notificationToDelete = fetchNotification(id: notification.id) else { return }
        do {
            moc.delete(notificationToDelete)
            try moc.save()
        } catch {
            NSLog("Error - Could not delete notification, " +
                String(describing: notificationToDelete.id) +
                " \(error) \(error.localizedDescription)")
        }
    }
}
