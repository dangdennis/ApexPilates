//
//  DetailedWorkoutView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/17/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct DetailedWorkoutView: View {
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
    }
}

struct DetailedWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let context = persistentStore.persistentContainer.viewContext
        
        let workout = SeedData(context: persistentStore.persistentContainer.viewContext).workout()
        
        return DetailedWorkoutView(workout: workout).environment(\.managedObjectContext, context)
    }
}
