//
//  Result.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 13/04/24.
//

import Foundation
import SwiftData

@available(iOS 17, *)
@Model
class TestResult{
    var activity:String
    var completed:Bool
    var grade:Int
    var time:String
    var errors:Int
    var session: Session?
    
    init(activity:String, completed: Bool, grade: Int, time: String, errors: Int, session: Session? = nil) {
        self.completed = completed
        self.grade = grade
        self.time = time
        self.errors = errors
        self.session = session
        self.activity = activity
    }
}
