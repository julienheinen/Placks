//
//  PlacksApp.swift
//  Placks
//
//  Created by Julien Heinen on 17/05/2021.
//

import SwiftUI
import Clarity

@main
struct PlacksApp: App {
    init() {
        let clarityConfig = ClarityConfig(projectId: "nc1a0r7c7n")
        ClaritySDK.initialize(config: clarityConfig)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

