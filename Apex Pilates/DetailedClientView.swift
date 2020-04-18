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
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(client.wrappedWorkouts) { workout in
                    NavigationLink(destination: DetailedWorkoutView(workout: workout)) {
                        Text(workout.wrappedName)
                    }
                }
            }
            Spacer()
        }
        .navigationBarTitle(Text(client.name ?? ""))
        
    }
}

struct DetailedClientView_Previews: PreviewProvider {
    static var previews: some View {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let client = SeedData().client()
        
        return DetailedClientView(client: client).environment(\.managedObjectContext, context)
    }
}
