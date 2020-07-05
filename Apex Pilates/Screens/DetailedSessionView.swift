//
//  DetailedSessionView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 5/1/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct DetailedSessionView: View {
    @Environment(\.managedObjectContext) var ctx
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var session: WorkoutSession
    
    var body: some View {
        List {
            ForEach(session.wrappedExercises, id: \.self) { (exercise: Exercise) in
                Text(exercise.wrappedName)
            }
        }.navigationBarTitle(session.wrappedTitle + " " + session.wrappedCompletionDate)
            .navigationBarItems(trailing: Button(action: {
                self.deleteSession()
                self.mode.wrappedValue.dismiss()
            }) {
                Text("Delete")
            })
    }
    
    private func deleteSession() {
        self.ctx.delete(session)
        
    }
}

struct DetailedSessionView_Previews: PreviewProvider {
    static var previews: some View {
        let seedData = SeedData(context: persistentStore.persistentContainer.viewContext)
        let sess = seedData.workoutSession()
        return DetailedSessionView(session: sess)
    }
}


