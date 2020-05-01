//
//  DetailedSessionView.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 5/1/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI

struct DetailedSessionView: View {
    var session: WorkoutSession
    var body: some View {
        List {
            ForEach(session.wrappedExercises, id: \.self) { (exercise: Exercise) in
                Text(exercise.wrappedName)
            }
        }.navigationBarTitle(session.wrappedTitle + " " + session.wrappedCompletionDate)
    }
}

struct DetailedSessionView_Previews: PreviewProvider {
    static var previews: some View {
        let seedData = SeedData()
        let sess = seedData.workoutSession()
        return DetailedSessionView(session: sess)
    }
}
