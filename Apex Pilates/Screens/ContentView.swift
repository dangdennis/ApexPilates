//
//  ContentView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            ClientsView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Clients")
            }
            
            WorkoutsView()
                .tabItem {
                    Image(systemName: "bolt.fill")
                    Text("Workouts")
            }
            
            ExercisesView()
                .tabItem {
                    Image(systemName: "flame.fill")
                    Text("Exercises")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let context = persistentStore.persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}
