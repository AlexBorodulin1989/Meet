//
//  PresentationView.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import Foundation
import RealmSwift

final class PresentationViewModel {
    var meet: ObservableObject<Meet?> = ObservableObject(nil)
    
    private var notificationToken: NotificationToken?
    
    private let realm = try! Realm()
    private lazy var meets: Results<Meet> = { self.realm.objects(Meet.self) }()
    
    func viewDidLoad() {
        notificationToken = meets.observe({[weak self] _ in
            self?.meet.value = self?.meets.first
        })
    }
}
