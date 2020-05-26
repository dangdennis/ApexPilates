//
//  WorkoutsView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct WorkoutsView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Workout.entity(), sortDescriptors: []) var allWorkouts: FetchedResults<Workout>
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Enter workout name", text: $name, onCommit: addWorkout)
                    .padding(.leading, 20)
                
                List {
                    ForEach(allWorkouts) { workout in
                        NavigationLink(destination: DetailedWorkoutView(workout: workout)) {
                            Text(workout.wrappedName)
                        }
                    }.onDelete(perform: removeWorkout)
                }
                
                Spacer()
            }
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Workouts"))
        }
    }
    
    func addWorkout() {
        let newWorkout = Workout(context: context)
        newWorkout.id = UUID()
        newWorkout.name = name
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        reset()
    }
    
    func removeWorkout(offsets: IndexSet) {
        for i in offsets {
            let workout = self.allWorkouts[i]
            self.context.delete(workout)
        }
    }
    
    func reset() {
        name = ""
    }
}

struct WorkoutsView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return WorkoutsView().environment(\.managedObjectContext, context)
    }
}
