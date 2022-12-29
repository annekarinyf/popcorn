//
//  ManagedShowImage.swift
//  PopcornCore
//
//  Created by anne.freitas on 29/12/22.
//
//

import CoreData

@objc(ManagedShowImage)
public class ManagedShowImage: NSManagedObject {
    @NSManaged public var medium: URL?
    @NSManaged public var original: URL
    @NSManaged public var show: ManagedShow
}
