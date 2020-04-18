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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ContentView().environment(\.managedObjectContext, context)
    }
}

struct DetailedClientView: View {
    var clientID: UUID
    //    @State private var exercises = mockExercises
    
    var body: some View {
        Text("Detailed client view")
        //        List {
        //            Section(header: Text("Client")) {
        //                Text("Dennis Dang")
        //            }
        //            Section(header: Text("Today's Workout")) {
        //                ForEach(exercises) { exercise in
        //                    Text(exercise.name)
        //                }
        //                .onDelete(perform: deleteExercise)
        //                .onMove(perform: moveExercise)
        //            }
        //        }
        //        .listStyle(GroupedListStyle())
        //        .navigationBarItems(trailing: EditButton())
    }
    
    //    func deleteExercise(at offsets: IndexSet) {
    //        exercises.remove(atOffsets: offsets)
    //    }
    //
    //    func moveExercise(from source: IndexSet, to destination: Int) {
    //        exercises.move(fromOffsets: source, toOffset: destination)
    //    }
}
