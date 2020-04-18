//
//  Client+Extension.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import Foundation

extension Client {
    public var wrappedName: String {
        self.name ?? "Unknown client"
    }
    
    public var wrappedWorkouts: [Workout] {
        let set = workouts as? Set<Workout> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}
