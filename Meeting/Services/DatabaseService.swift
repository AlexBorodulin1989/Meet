//
//  DatabaseService.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import Foundation
import RealmSwift

final class DatabaseService {
    static let shared = DatabaseService()
    
    func saveMeeting(name: String,
                     place: String,
                     desc: String,
                     startDate: Date,
                     endDate: Date,
                     completion: @escaping() -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) {
            let realm = try! Realm()
            
            let meet = realm.objects(Meet.self).first
            
            try! realm.write() {
                if meet != nil {
                    meet!.name = name
                    meet!.place = place
                    meet!.desc = desc
                    meet!.startDate = startDate
                    meet!.endDate = endDate
                } else {
                    let newMeet = Meet()
                    newMeet.name = name
                    newMeet.place = place
                    newMeet.desc = desc
                    newMeet.startDate = startDate
                    newMeet.endDate = endDate
                    
                    realm.add(newMeet)
                }
                
            }
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }
}
