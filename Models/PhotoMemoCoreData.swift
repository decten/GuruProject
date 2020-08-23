//
//  Photomemo+CoreDataClass.swift
//  MemoWithCollectionView
//


import Foundation
import CoreData

@objc(Photomemo)
public class Photomemo: NSManagedObject {
    
}
extension Photomemo {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photomemo> {
        return NSFetchRequest<Photomemo>(entityName: "Photomemo")
    }

    @NSManaged public var contents: String?
    @NSManaged public var createdAt: NSDate?
    @NSManaged public var name: String?
    @NSManaged public var breed: String?
    @NSManaged public var sex: String?
    @NSManaged public var birth: String?
    @NSManaged public var weight: String?
    @NSManaged public var photo: NSData?

}
