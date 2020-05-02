//
//  DetailedClientView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/17/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI
import BasicThemeKit


struct DetailedClientView: View {
    var client: Client
    @State private var detailTypeSelection = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker(selection: $detailTypeSelection, label: Text("See workouts or sessions")) {
                Text("Workouts").tag(0)
                Text("Sessions").tag(1)
            }.pickerStyle(SegmentedPickerStyle())
            
            if detailTypeSelection == 0 {
                AllWorkoutsView(client: client)
            }
            else {
                AllSessionsView(client: client)
            }
            Spacer()
        }
        .padding(.horizontal, 8)
        .navigationBarTitle(Text(client.name ?? ""))
        
    }
}

struct DetailedClientView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let seeder = SeedData()
        let client = seeder.client()
        
        return DetailedClientView(client: client).environment(\.managedObjectContext, context)
    }
}

struct AllWorkoutsView: View {
    var client: Client
    @Environment(\.managedObjectContext) var context
    @FetchRequest(entity: Workout.entity(), sortDescriptors: []) var allWorkouts: FetchedResults<Workout>
    
    @State private var sheetOpen = false
    @State private var selectedWorkouts: [String: Bool] = [:]
    
    private func selectWorkout(id: String) {
        guard let prevState = self.selectedWorkouts[id] else {
            self.selectedWorkouts[id] = true
            return
        }
        
        self.selectedWorkouts[id] = !prevState
    }
    
    private func addWorkouts() {
        var selection: [Workout] = []
        for workout in allWorkouts {
            if selectedWorkouts[workout.wrappedID.uuidString] != nil {
                selection.append(workout)
            }
        }
        
        client.addToWorkouts(NSSet(array: selection))
    }
    
    var body: some View {
        List {
            ForEach(client.wrappedWorkouts) { workout in
                NavigationLink(destination: CompleteSessionView(workout: workout, client: self.client)) {
                    Text(workout.wrappedName)
                }
            }
        }
        .navigationBarItems(trailing: Button(action: {
            self.sheetOpen.toggle()
        }) {
            Text("Add")
        })
            .sheet(isPresented: $sheetOpen) {
                VStack {
                    Text("Select to add")
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

struct AllSessionsView: View {
    var client: Client
    var body: some View {
        return List {
            ForEach(client.wrappedWorkoutSessions) { session in
                NavigationLink(destination: DetailedSessionView(session: session)) {
                    HStack {
                        Text(session.wrappedTitle)
                        Text(session.wrappedCompletionDate)
                    }
                }
            }
        }
    }
}
