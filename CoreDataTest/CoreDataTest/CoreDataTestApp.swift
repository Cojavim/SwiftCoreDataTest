//
//  CoreDataTestApp.swift
//  CoreDataTest
//
//  Created by Tomáš Valášek on 24.09.2022.
//

import SwiftUI

@main
struct CoreDataTestApp: App {

    var body: some Scene {
        WindowGroup {
            let coreDM = CoreDataManager.shared
            ContentView().environment(\.managedObjectContext, coreDM.viewContext)
        }
    }
}
