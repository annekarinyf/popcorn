//
//  ManagedCache.swift
//  PopcornCore
//
//  Created by anne.freitas on 29/12/22.
//
//

import CoreData

@objc(ManagedCache)
public class ManagedCache: NSManagedObject {
    @NSManaged public var timestamp: Date
    @NSManaged public var shows: NSOrderedSet
}

extension ManagedCache {
     static func find(in context: NSManagedObjectContext) throws -> ManagedCache? {
         let request = NSFetchRequest<ManagedCache>(entityName: entity().name!)
         request.returnsObjectsAsFaults = false
         return try context.fetch(request).first
     }

     static func newUniqueInstance(in context: NSManagedObjectContext) throws -> ManagedCache {
         try find(in: context).map(context.delete)
         return ManagedCache(context: context)
     }

     var localShows: [LocalShow] {
         shows.compactMap { ($0 as? ManagedShow)?.local }
     }
 }
