//
//  GIF_AppApp.swift
//  GIF App
//
//  Created by Apar256 on 26/06/22.
//

import SwiftUI

@main
struct GIF_AppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
