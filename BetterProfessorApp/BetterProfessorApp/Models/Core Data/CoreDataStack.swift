//
//  CoreDataStack.swift
//  Better Professor Mockups
//
//  Created by Cody Morley on 4/27/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
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
}
