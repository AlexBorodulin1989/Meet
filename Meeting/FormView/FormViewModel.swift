//
//  FormViewModel.swift
//  Meeting
//
//  Created by Aleksandr Borodulin on 16.06.2022.
//

import Foundation

final class FormViewModel {
    
    var updated: ObservableObject<Bool> = ObservableObject(true)
    
    func save(name: String,
              place: String,
              desc: String,
              startDate: Date,
              endDate: Date) {
        
        self.updated.value = false
        
        DatabaseService.shared.saveMeeting(name: name,
                                           place: place,
                                           desc: desc,
                                           startDate: startDate,
                                           endDate: endDate) { [weak self] in
            self?.updated.value = true
        }
    }
}
