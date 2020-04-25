//
//  WorkoutSessionView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/25/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct WorkoutSessionView: View {
    var workout: Workout
    @State private var selectedExercises: [String: Bool] = [:]
    @State private var isOpen = false
    @State private var onlyChecked = false
    
    private var visibleExercises: [Exercise] {
        return workout.wrappedExercises.filter({ exercise in
            if self.onlyChecked {
                return self.selectedExercises[exercise.wrappedID] ?? false
            }
            return true
        })
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                List {
                    ForEach(self.visibleExercises, id: \.self) { (exercise: Exercise) in
                        HStack {
                            Text(exercise.wrappedName)
                            self.selectedExercises[exercise.wrappedID] ?? false
                                ? Image(systemName: "checkmark.circle.fill")
                                : Image(systemName: "checkmark.circle")
                            
                        }.onTapGesture {
                            if let prevState = self.selectedExercises[exercise.wrappedID] {
                                self.selectedExercises[exercise.wrappedID] = !prevState
                            } else {
                                self.selectedExercises[exercise.wrappedID] = true
                            }
                        }
                    }
                }.actionSheet(isPresented: $isOpen, content: {
                    ActionSheet(
                        title: Text("Hi Megumi"),
                        message: Text("Youre a pooper face"),
                        buttons: [
                            .default(Text("Show Only Checked"), action: { self.onlyChecked = true }),
                            .cancel(Text("Show All"), action: { self.onlyChecked = false })
                    ])
                })
                
                VStack {
                    Spacer()
                    
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            self.isOpen.toggle()
                        }) {
                            HStack {
                                Image(systemName: "line.horizontal.3.decrease")
                            }
                            .font(.system(.title))
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color.white)
                        }.background(Color.blue)
                            .cornerRadius(100)
                            .padding(.trailing, 20)
                            .padding(.bottom, 10)
                            .shadow(color: Color.black.opacity(0.3),
                                    radius: 3,
                                    x: 3,
                                    y: 3)
                    }
                    
                }
            }
        }
        .navigationBarTitle(workout.wrappedName)
    }
}

struct SessionView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let workout = SeedData().workout()
        
        return DetailedWorkoutView(workout: workout).environment(\.managedObjectContext, context)
    }
}
