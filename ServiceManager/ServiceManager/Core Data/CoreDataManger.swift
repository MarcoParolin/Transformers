//
//  CoreDataManger.swift
//  ServiceManager
//
//  Created by Marco Parolin on 13/09/2019.
//  Copyright © 2019 Marco Parolin. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager {

    static let shared = CoreDataManager()
    init() {}

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Transformers", managedObjectModel: self.managedObjectModel)
        container.loadPersistentStores(completionHandler: { (_, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            container.viewContext.automaticallyMergesChangesFromParent = true
            container.viewContext.mergePolicy = NSMergePolicy.mergeByPropertyObjectTrump
        })
        return container
    }()

    private lazy var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle(identifier: "it.parolinonline.ServiceManager")
        guard let modelUrl = bundle?.url(forResource: "Transformers", withExtension: "momd"),
            let model = NSManagedObjectModel(contentsOf: modelUrl) else {
            fatalError("")
        }
        return model
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    /// Returns a list of transformers currently saved into core data
    func getTransformers() -> [Transformer] {
        var transformers: [Transformer] = []
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTransformer")
        do {
            let res = try CoreDataManager.shared.persistentContainer.viewContext.fetch(fetchRequest)
            guard let result  = res as? [ManagedTransformer] else {
                fatalError()
            }
            for data in result {
                transformers.append(Transformer(data))
            }
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        return transformers
    }

    /// Save a list of transformers into core data
    func saveTransformers(_ transformers: [Transformer]) {
        _ = transformers.map { $0.asManagedTransformer() }
        CoreDataManager.shared.saveContext()
    }
    
    /// debuf function, just in case I need to empty db for some reason
    func emptyDB() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedTransformer")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try CoreDataManager.shared.persistentContainer.viewContext.execute(deleteRequest)
            CoreDataManager.shared.saveContext()
        } catch {
            print(error)
        }
    }
}
