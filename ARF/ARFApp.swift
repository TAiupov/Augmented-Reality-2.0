//
//  ARFApp.swift
//  ARF
//
//  Created by Тагир Аюпов on 2021-06-23.
//

import SwiftUI

@main
struct ARFApp: App {
    @StateObject var placementSettings = PlacementSettings()
    @StateObject var sessionSettings = SessionSettings()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(placementSettings)
                .environmentObject(sessionSettings)
        }
    }
}
