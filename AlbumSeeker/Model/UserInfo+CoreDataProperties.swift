//
//  UserInfo+CoreDataProperties.swift
//  AlbumSeeker
//
//  Created by user on 03.12.2021.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var age: Int32
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var phoneNumber: String?
    @NSManaged public var surname: String?

}

extension UserInfo : Identifiable {

}
