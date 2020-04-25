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
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let seeder = SeedData()
        let client = seeder.client()
        
        return DetailedClientView(client: client).environment(\.managedObjectContext, context)
    }
}

struct AllWorkoutsView: View {
    var client: Client
    var body: some View {
        List {
            ForEach(client.wrappedWorkouts) { workout in
                NavigationLink(destination: CompleteSessionView(workout: workout, client: self.client)) {
                    Text(workout.wrappedName)
                }
            }
        }
    }
}

struct AllSessionsView: View {
    var client: Client
    var body: some View {
        List {
            ForEach(client.wrappedWorkoutSessions) { session in
                HStack {
                    Text(session.wrappedTitle)
                    Text(session.wrappedCompletionDate)
                }
            }
        }
    }
}
