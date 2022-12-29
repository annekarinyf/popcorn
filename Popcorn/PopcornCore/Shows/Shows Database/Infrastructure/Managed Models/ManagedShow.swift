//
//  ManagedShow.swift
//  PopcornCore
//
//  Created by anne.freitas on 29/12/22.
//
//

import CoreData

@objc(ManagedShow)
public class ManagedShow: NSManagedObject {
    @NSManaged public var id: Int64
    @NSManaged public var url: URL
    @NSManaged public var name: String
    @NSManaged public var status: String
    @NSManaged public var language: String
    @NSManaged public var summary: String
    @NSManaged public var image: ManagedShowImage
    @NSManaged public var cache: ManagedCache
}

extension ManagedShow {
    static func shows(from localShows: [LocalShow], in context: NSManagedObjectContext) -> NSOrderedSet {
        NSOrderedSet(array: localShows.map { local in
            let managedShow = ManagedShow(context: context)
            managedShow.id = Int64(local.id)
            managedShow.url = local.url
            managedShow.name = local.name
            managedShow.status = local.status
            managedShow.language = local.language
            managedShow.summary = local.summary
            
            let managedImage = ManagedShowImage(context: context)
            managedImage.original = local.image.original
            managedImage.medium = local.image.medium
            
            managedShow.image = managedImage
            return managedShow
        })
    }
    
    var local: LocalShow {
        LocalShow(
            id: Int(id),
            url: url,
            name: name,
            status: status,
            language: language,
            summary: summary,
            image: .init(
                medium: image.medium,
                original: image.original
            )
        )
    }
}
