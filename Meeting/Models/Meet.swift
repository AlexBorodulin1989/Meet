//
//  Meet.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import Foundation
import RealmSwift

class Meet: Object {
    @objc dynamic var name = ""
    @objc dynamic var place = ""
    @objc dynamic var desc = ""
    @objc dynamic var startDate = Date()
    @objc dynamic var endDate = Date()
}
