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
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Client: Identifiable {
    var id = UUID()
    var name: String
}

struct Exercise: Identifiable {
    var id = UUID()
    var name: String
}

struct Workout: Identifiable {
    var id = UUID()
    var name: String
}

let mockClients = [
    Client(name: "Dennis Dang"),
    Client(name: "Megumi Iwama"),
    Client(name: "Bret Fart Face"),
]


let mockWorkouts = [
    Workout(name: "Workout Sesh 1"),
    Workout(name: "Workout Sesh 2"),
    Workout(name: "Workout Sesh 3"),
]

let mockExercises = [
    Exercise(name: "stretching dog"),
    Exercise(name: "flying monkey"),
    Exercise(name: "sleeping child"),
]


struct WorkoutsView: View {
    @State private var workouts = mockWorkouts
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Workouts")) {
                    ForEach(workouts) { workout in
                        Text(workout.name)
                    }.onDelete(perform: { offsets in
                        self.workouts.remove(atOffsets: offsets)
                    }).onMove(perform: { (offsets, destination) in
                        self.workouts.move(fromOffsets: offsets, toOffset: destination)
                    })
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Workouts"))
        }
    }
}

struct ClientsView: View {
    @State private var clients = mockClients
    
    var body: some View {
        NavigationView {
            List(clients) { client in
                NavigationLink(destination: DetailedClientView()) {
                    Text(client.name)
                }
            }
//            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Clients"))
        }
    }
    
    
    
}

struct DetailedClientView: View {
    @State private var exercises = mockExercises
    
    var body: some View {
        List {
            Section(header: Text("Client")) {
                Text("Dennis Dang")
            }
            Section(header: Text("Today's Workout")) {
                ForEach(exercises) { exercise in
                    Text(exercise.name)
                }
                .onDelete(perform: deleteExercise)
                .onMove(perform: moveExercise)
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarItems(trailing: EditButton())
    }
    
    func deleteExercise(at offsets: IndexSet) {
        exercises.remove(atOffsets: offsets)
    }
    
    func moveExercise(from source: IndexSet, to destination: Int) {
        exercises.move(fromOffsets: source, toOffset: destination)
    }
}

