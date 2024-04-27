//
//  Session.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 13/04/24.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
class Session{
    var date:String
    var key:String
    var patient: Patient?
    @Relationship(deleteRule:.cascade, inverse: \TestResult.session) var results: [TestResult]
    
    init(date: String, key: String, patient: Patient? = nil, results: [TestResult]) {
        self.date = date
        self.key = key
        self.patient = patient
        self.results = results
    }
}
