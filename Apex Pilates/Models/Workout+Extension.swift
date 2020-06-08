//
//  Workout+Extension.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/16/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import Foundation

extension Workout: Identifiable {
    public var wrappedName: String {
        self.name ?? "Unknown Workout"
    }
    
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
