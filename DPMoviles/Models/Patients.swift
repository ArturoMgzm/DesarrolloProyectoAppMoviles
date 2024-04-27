//
//  Patients.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 13/04/24.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
class Patient{
    var name:String
    var gender:String
    var hand:String
    var diagnostic:String
    var age:Int
    var lastVisit: String
    @Relationship(deleteRule:.cascade, inverse: \Session.patient) var sessions: [Session]
    
    init(name: String, gender: String, hand: String, diagnostic: String, age: Int, lastVisit: String,sessions: [Session]) {
        self.name = name
        self.gender = gender
        self.hand = hand
        self.diagnostic = diagnostic
        self.age = age
        self.sessions = sessions
        self.lastVisit = lastVisit
    }
}
