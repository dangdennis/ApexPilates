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
                List {
                    ForEach(allWorkouts) { workout in
                        Text(workout.name ?? "")
                    }
                }
                
                Spacer()
                
                TextField("Enter workout name", text: $name, onCommit: addWorkout)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
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
