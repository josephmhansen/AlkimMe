//
//  RoutineController.swift
//  AlkimMe
//
//  Created by Joseph Hansen on 10/6/16.
//  Copyright © 2016 Joseph Hansen. All rights reserved.
//

import Foundation

class RoutineController {
    
    static let sharedController = RoutineController()
    //research options to set a default string value for morning and evening times
    var morningFireTime: String?
    var eveningFireTime: String?
    
    
    func createRoutineFromCurrentShelf(){}
    func startRoutine(){}
    func stopRoutine(){}
    
    func saveMorningFireDate(){}
    func saveEveningFireDate(){}
    func checkDailySurveyStatus(){}
    func modifyRoutine(){}
}

extension Routine {
    
}
