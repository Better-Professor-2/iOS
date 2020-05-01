//
//  CoreDataStack.swift
//  BetterProfessorApp
//
//  Created by Cody Morley on 4/28/20.
//  Copyright © 2020 Lambda. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "BetterProfessor")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load persistent stores: \(error)")
            }
        }

        return container
    }()
    var mainContext: NSManagedObjectContext {
        return container.viewContext
    }
    // MARK: - Functions
    /// cross-object save function for saving MSManagedObjectContext to NSPersistentStore
    func saveToCoreData(context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        let currentObjectContext = context
        do {
            try currentObjectContext.save()
        } catch {
            NSLog("Error saving items to core data from \(context): \(error) \(error.localizedDescription)")
        }
    }

}
