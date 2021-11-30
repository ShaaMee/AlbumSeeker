//
//  UserInfo+CoreDataProperties.swift
//  AlbumSeeker
//
//  Created by user on 30.11.2021.
//
//

import Foundation
import CoreData


extension UserInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserInfo> {
        return NSFetchRequest<UserInfo>(entityName: "UserInfo")
    }

    @NSManaged public var name: String?
    @NSManaged public var surname: String?
    @NSManaged public var age: Int32
    @NSManaged public var phoneNumber: Int32
    @NSManaged public var email: String?
    @NSManaged public var password: String?

}

extension UserInfo : Identifiable {

}
