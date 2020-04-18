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
        NavigationView {
            VStack(alignment: .leading) {
                List {
                    ForEach(workout.wrappedExercises, id: \.self) { exercise in
                        Text(exercise.wrappedName)
                    }
                }
                Spacer()
            }
            .navigationBarTitle(workout.wrappedName)
        }
    }
    
}

struct DetailedWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let ex1 = Exercise.init(context: context)
        ex1.name = "Exercise 1"
        let ex2 = Exercise.init(context: context)
        ex2.name = "Exercise 2"
        
        let workout = Workout.init(context: context)
        workout.addToExercises(ex1)
        workout.addToExercises(ex2)
        workout.name = "Pilates Mat"
        
        return DetailedWorkoutView(workout: workout).environment(\.managedObjectContext, context)
    }
}
