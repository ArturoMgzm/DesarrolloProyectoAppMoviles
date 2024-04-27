//
//  DPMovilesApp.swift
//  DPMoviles
//
//  Created by Arturo Manrique on 15/03/24.
//

import SwiftUI
import SwiftData

@available(iOS 17.0, *)
@main
struct DPMovilesApp: App {
    var body: some Scene {
        WindowGroup {
            PatientsView()
        }
        .modelContainer(for: Patient.self)
        .modelContainer(for: Session.self)
        .modelContainer(for: TestResult.self)
    }
}
