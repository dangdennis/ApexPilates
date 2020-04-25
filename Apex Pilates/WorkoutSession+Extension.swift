//
//  WorkoutSession+Extension.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/25/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import Foundation

extension WorkoutSession: Identifiable {
    public var wrappedID: UUID {
        self.id ?? UUID()
    }
    
    public var wrappedExercises: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
}

