//
//  ApexPilatesApp.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 6/26/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import CoreData
import SwiftUI

let persistentStore = PersistentStore()

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        let _ = SeedData(context: persistentStore.persistentContainer.viewContext)
        return true
    }
}

@main
struct ApexPilatesApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView().environment(\.managedObjectContext, persistentStore.persistentContainer.viewContext)
        }.onChange(of: scenePhase) { phase in
            switch phase {
            case .active:
                print("active")
            case .inactive:
                print("inactive")
            case .background:
                print("background")
                persistentStore.saveContext()
            @unknown default:
                fatalError("unknown phase")
            }
        }
    }
}
