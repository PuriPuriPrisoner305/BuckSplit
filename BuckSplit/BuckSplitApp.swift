//
//  BuckSplitApp.swift
//  BuckSplit
//
//  Created by Ardyansyah Wijaya on 11/08/22.
//

import SwiftUI

@main
struct BuckSplitApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
