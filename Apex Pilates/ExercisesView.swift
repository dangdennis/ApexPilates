//
//  ExercisesView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct ExercisesView: View {
    @Environment(\.managedObjectContext) var context
    @FetchRequest(
        entity: Exercise.entity(),
        sortDescriptors: [NSSortDescriptor(keyPath: \Exercise.order, ascending: true)]
    ) var allExercises: FetchedResults<Exercise>
    @State private var name = ""
    
    var body: some View {
        NavigationView {
            VStack() {
                
                List {
                    Section(header: Text("Mat")) {
                        ForEach(allExercises) { workout in
                            Text(workout.name ?? "")
                        }.onDelete(perform: deleteExercise)
                    }.listStyle(GroupedListStyle())
                }
                
                Spacer()
                
                TextField("Enter exercise name", text: $name, onCommit: addExercise)
                    .padding(.bottom, 20)
                    .padding(.leading, 20)
            }
            .navigationBarItems(trailing: EditButton())
            .navigationBarTitle(Text("Exercises"))
        }
    }
    
    func deleteExercise(offsets: IndexSet) {
        for i in offsets {
            let exercise = self.allExercises[i]
            self.context.delete(exercise)
        }
    }
    
    func addExercise() {
        let newExercise = Exercise(context: context)
        newExercise.id = UUID()
        newExercise.name = name
        
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

struct ExercisesView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        return ExercisesView().environment(\.managedObjectContext, context)
    }
}
