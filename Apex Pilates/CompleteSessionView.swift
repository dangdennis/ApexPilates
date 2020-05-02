//
//  CompleteSessionView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/25/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct CompleteSessionView: View {
    @Environment(\.managedObjectContext) var context
    @Environment(\.presentationMode) var presentation
    
    var workout: Workout
    var client: Client
    
    @State private var showPopover: Bool = false
    @State private var sessionTitle = ""
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
    
    // completeSession adds a new session of completed exercises for the prescribed client
    private func completeSession() {
        let d = Date()
        let sess = WorkoutSession(context: self.context)
        sess.completedOn = d
        sess.id = UUID()
        sess.title = self.sessionTitle
        
        let s = (workout.exercises?.allObjects ?? []) as [Exercise]
        
        var selection: [Exercise] = []
        for e in s {
            if selectedExercises[e.wrappedID] != nil {
                selection.append(e)
            }
        }
        
        sess.addToExercises(NSSet(array: selection))
        
        client.addToWorkoutSessions(sess)
        
        presentation.wrappedValue.dismiss()
    }
    
    private func selectExercise(id: String) {
        guard let prevState = self.selectedExercises[id] else {
            self.selectedExercises[id] = true
            return
        }
        
        self.selectedExercises[id] = !prevState
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                List {
                    ForEach(self.visibleExercises) { (exercise: Exercise) in
                        Button(action: {
                            
                            self.selectExercise(id: exercise.wrappedID)
                            
                        }) {
                            HStack {
                                Text(exercise.wrappedName)
                                Spacer()
                                if self.selectedExercises[exercise.wrappedID] ?? false {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                
                            }
                            
                        }
                    }
                }.actionSheet(isPresented: $isOpen, content: {
                    ActionSheet(
                        title: Text("Hi Megumi"),
                        message: Text("Youre a pooper face"),
                        buttons: [
                            .default(Text("Show Only Checked"), action: { self.onlyChecked = true }),
                            .default(Text("Complete workout"), action: { self.completeSession() }),
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
                        }.background(Color.black)
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
        .popover( isPresented: self.$showPopover, arrowEdge: .bottom) {
            VStack {
                Text("Name your session")
                HStack {
                    TextField("Title", text: self.$sessionTitle, onCommit: {
                        self.completeSession()
                        self.showPopover.toggle()
                    })
                    Spacer()
                    Button(action: {
                        self.completeSession()
                        self.showPopover.toggle()
                    }) {
                        Text("Submit")
                    }
                }
                
                Spacer()
            }
            .padding(16)
            .padding(.top, 16)
        }
        .navigationBarItems(trailing: Button(action: {
            self.showPopover.toggle()
        }) {
            Text("Complete Session")
        })
            .navigationBarTitle(workout.wrappedName)
    }
}

struct CompleteSessionView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let workout = SeedData().workout()
        return DetailedWorkoutView(workout: workout).environment(\.managedObjectContext, context)
    }
}
