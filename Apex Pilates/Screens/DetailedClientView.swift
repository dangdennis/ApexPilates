//
//  DetailedClientView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/17/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI


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
        let context = persistentStore.persistentContainer.viewContext
        
        let seeder = SeedData(context: context)
        let client = seeder.client()
        
        return DetailedClientView(client: client).environment(\.managedObjectContext, context)
    }
}

struct AllWorkoutsView: View {
    var client: Client
    @Environment(\.managedObjectContext) var context
    
    // fetch all workouts ahead of time so user can assign workouts to their client
    @FetchRequest(entity: Workout.entity(), sortDescriptors: []) var allWorkouts: FetchedResults<Workout>
    
    // state to manage addition of new workouts
    @State private var sheetOpen = false
    @State private var selectedWorkouts: [String: Bool] = [:]
    
    // store a map of workouts that have been selected for assignment to client
    private func selectWorkout(id: String) {
        guard let prevState = self.selectedWorkouts[id] else {
            self.selectedWorkouts[id] = true
            return
        }
        
        self.selectedWorkouts[id] = !prevState
    }
    
    // add a workout to a client's list of assigned workouts
    private func addWorkouts() {
        for workout in allWorkouts {
            if selectedWorkouts[workout.wrappedID.uuidString] != nil {
                client.addToWorkouts(workout)
            }
        }
    }
    
    // remove a client's assigned workout
    private func deleteWorkout(offsets: IndexSet) {
        for i in offsets {
            let workout = client.wrappedWorkouts[i]
            client.removeFromWorkouts(workout)
        }
    }
    
    var body: some View {
        List {
            ForEach(client.wrappedWorkouts) { workout in
                NavigationLink(destination: CompleteSessionView(workout: workout, client: self.client)) {
                    Text(workout.wrappedName)
                }
            }.onDelete(perform: self.deleteWorkout)
        }
        .navigationBarItems(trailing: Button(action: {
            self.sheetOpen.toggle()
        }) {
            Text("Add")
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

struct AllSessionsView: View {
    @Environment(\.managedObjectContext) var context
    var client: Client
    var sessionsRequest: FetchRequest<WorkoutSession>
    var sessions: FetchedResults<WorkoutSession>{sessionsRequest.wrappedValue}
    
    init(client: Client) {
        self.client = client
        self.sessionsRequest = FetchRequest(
            entity: WorkoutSession.entity(),
            sortDescriptors: [],
            predicate: NSPredicate(format: "%K == %@", #keyPath(WorkoutSession.clients), client)
        )
    }
    
    var body: some View {
        List {
            ForEach(sessions) { (session: WorkoutSession) in
                NavigationLink(destination: DetailedSessionView(session: session)) {
                    HStack {
                        Text(session.wrappedTitle)
                        Text(session.wrappedCompletionDate)
                    }
                }
            }
        }.navigationBarItems(trailing: Text(""))
    }
}
