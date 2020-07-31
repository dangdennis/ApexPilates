//
//  DetailedWorkoutView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/17/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct DetailedWorkoutView: View {
    @State private var sheetOpen = false
    var workout: Workout
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                List {
                    ForEach(workout.wrappedExercises, id: \.self) { (exercise: Exercise) in
                        Text(exercise.wrappedName)
                    }
                }
            }
        }
        .navigationBarTitle(workout.wrappedName)
        .navigationBarItems(trailing: Button(action: {
            self.sheetOpen.toggle()
        }) {
            Text("New")
        })
            .sheet(isPresented: $sheetOpen) {
                VStack {
                    Text("Start new session")
                        .h3()
                    List {
                        ForEach(self.allWorkouts) { (workout: Workout) in
                            Button(action: {
                                self.selectWorkout(id: workout.wrappedID.uuidString)
                            }) {
                                HStack {
                                    Text(workout.wrappedName)
                                    Spacer()
                                    if self.selectedWorkouts[workout.wrappedID.uuidString] ?? false {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                            }
                        }
                    }
                    Spacer()
                    Button(action: {
                        self.addWorkouts()
                        self.sheetOpen.toggle()
                    }) {
                        HStack {
                            Text("Add")
                            Image(systemName: "plus")
                        }
                    }
                    .frame(width: 100)
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(40)
                    
                }.padding(.top, 24)
        }
    }
}

struct DetailedWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let context = persistentStore.persistentContainer.viewContext
        let workout = SeedData(context: persistentStore.persistentContainer.viewContext).workout()
        return DetailedWorkoutView(workout: workout).environment(\.managedObjectContext, context)
    }
}
