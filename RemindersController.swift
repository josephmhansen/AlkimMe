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
    
    
    var reminderAccessGranted: Bool {
        var success: Bool = true
        ReminderController.sharedController.eventStore?.requestAccess(to: .reminder, completion: { (access, error) in
            if error != nil {
                print("Error requesting access: \(error?.localizedDescription)")
            }
            success = access
        })
        return success
    }
    
    var eventStore: EKEventStore?
    
    init() {
        self.eventStore = EKEventStore()
    }
    
    var reminders: [EKReminder]?
    
    //creating for first time
    func createNewReminder(forReminder reminder: NSDate) {
        guard let eventStore = eventStore else { return }
        let newReminder = EKReminder.init(eventStore: eventStore)
        //newReminder.
    }
    
    //modifying
    func changeSelectedReminder(forReminder reminderIdentifier: String) {
        
    }
    
    //deleting
    func cancelAllReminders(forReminders remindersIdentifiers: [String] ) {
        
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


