//
//  DootyApp.swift
//  Dooty
//
//  Created by Vladislavs Buzinskis on 19/07/2022.
//

import SwiftUI

@main
struct DootyApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            DootyListView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
