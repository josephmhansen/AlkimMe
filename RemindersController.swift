//
//  RemindersController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/21/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation
import EventKit
import EventKitUI

class ReminderController {
    static let sharedController = ReminderController()
    
    var reminderAccessGranted: Bool = false
    
    let eventStore = EKEventStore()
    
    var reminders: [EKReminder]?
    
    func requestAccessToReminders() {
        eventStore.requestAccess(to: EKEntityType.reminder) { (accessGranted, error) in
            
            if accessGranted == true {
                dispatchMain()
                
            }
        }
    }
    
//    func loadReminders() {
//        guard let
//        self.reminders = eventStore.event(withIdentifier: <#T##String#>)
//    }
    
//Permission granted function
    
//Create: create daily reminder, use enum for morning and evening
    
//Edit: delete old reminder, and create reminder at new time
    
//Delete all: fetch all from data base by identifier, then delete all reminders
    
}
