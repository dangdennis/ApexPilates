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
    
    public var wrappedTitle: String {
        self.title ?? "Recently Deleted"
    }
    
    public var wrappedCompletionDate: String {
        guard let d = completedOn else {
            return ""
        }
        let fmt = DateFormatter()
        fmt.timeStyle = .medium
        fmt.dateFormat = "MM-dd-yyyy"
        return fmt.string(from: d)
    }
    
    public var wrappedExercises: [Exercise] {
        let set = exercises as? Set<Exercise> ?? []
        return set.sorted {
            $0.order < $1.order
        }
    }
}

