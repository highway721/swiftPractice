//
//  Saving+CoreDataProperties.swift
//  SavingImgCoreData
//
//  Created by Yusuke Tomatsu on 2020/10/01.
//
//

import Foundation
import CoreData


extension Saving {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Saving> {
        return NSFetchRequest<Saving>(entityName: "Saving")
    }

    @NSManaged public var username: String?
    @NSManaged public var imageD: Data?
    @NSManaged public var favo: Bool
    @NSManaged public var descriptions: String?

}

extension Saving : Identifiable {

}
