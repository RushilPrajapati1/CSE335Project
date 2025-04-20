//
//  CSE335ProjectApp.swift
//  CSE335Project
//
//  Created by Rushil Prajapati on 3/24/25.
//

import SwiftData
import SwiftUI

@main
struct CSE335ProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
