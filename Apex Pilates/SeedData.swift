//
//  SeedData.swift
//  Apex Pilates
//
//  Created by Dennis Dang on 4/17/20.
//  Copyright © 2020 dlab. All rights reserved.
//

import SwiftUI
import Foundation
import CoreData

public class SeedData {
    let context: NSManagedObjectContext
    
    init() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.context = appDelegate.persistentContainer.viewContext
    }
    
    func seedExercises() {
        var order: Double = 1
        for exercise in matExercises {
            let newExercise = Exercise(context: self.context)
            newExercise.name = exercise.name
            newExercise.id = UUID()
            newExercise.type = exercise.type
            newExercise.order = order
            order = order + 1
        }
        
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
    
    func printExercises() {
        let allExercises = findAllExercises(type: "Exercise")
        for exercise in allExercises {
            print("\(exercise.name ?? "") -- Type: \(exercise.type ?? "") -- \(exercise.order)")
        }
        
    }
    
    func seedWorkouts() {
        let allMatExercises = findAllExercises(type: "Exercise")
        let newMatWorkout = Workout(context: self.context)
        newMatWorkout.id = UUID()
        newMatWorkout.name = "Pilates Mat"
        let set = NSSet.init(array: allMatExercises)
        newMatWorkout.exercises = set
    }
    
    func deleteAll() {
        let fetch = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        let req = NSBatchDeleteRequest(fetchRequest: fetch)
        do {
            try self.context.execute(req)
        } catch{
            print(error)
        }
    }
    
    func findAllExercises(type: String) -> [Exercise] {
        let req = NSFetchRequest<Exercise>(entityName: type)
        let sortDesc = NSSortDescriptor(key: "order", ascending: true)
        req.sortDescriptors = [sortDesc]
        req.resultType = .managedObjectResultType
        
        do {
            return try self.context.fetch(req)
        } catch let error as NSError {
            print("Could not fetch. \(error). \(error.userInfo)")
            return []
        }
    }
}

let matExercises = [
    (name: "The Hundred", type: "mat"),
    (name: "Roll Up", type:"mat"),
    (name: "Roll Over", type:"mat"),
    (name: "Single Leg Circles", type:"mat"),
    (name: "Rolling Like a Ball", type:"mat"),
    (name: "Single Leg Stretch", type:"mat"),
    (name: "Double Leg Stretch", type:"mat"),
    (name: "Spine Stretch Forward", type:"mat"),
    (name: "Open Leg Rocker", type:"mat"),
    (name: "Corkscrew", type:"mat"),
    (name: "Saw", type:"mat"),
    (name: "Swan", type:"mat"),
    (name: "Single Leg Kicks", type:"mat"),
    (name: "Double Leg Kicks", type:"mat"),
    (name: "Neck Pull", type:"mat"),
    (name: "High Scissors", type:"mat"),
    (name: "High Bicycle", type:"mat"),
    (name: "Shoulder Bridge", type:"mat"),
    (name: "Spine", type:"mat"),
    (name: "Twist", type:"mat"),
    (name: "Jackknife", type:"mat"),
    (name: "Side Kick Series -Front/Back", type:"mat"),
    (name: "Teaser 1", type:"mat"),
    (name: "Teaser 2", type:"mat"),
    (name: "Teaser 3", type:"mat"),
    (name: "Hip Circles", type:"mat"),
    (name: "Swimming", type:"mat"),
    (name: "Leg Pull Front (Down)", type:"mat"),
    (name: "Leg Pull Back (Up)", type:"mat"),
    (name: "Kneeling Side Kicks", type:"mat"),
    (name: "Side Bend", type:"mat"),
    (name: "Boomerang", type:"mat"),
    (name: "Seal Crab", type:"mat"),
    (name: "Rocking", type:"mat"),
    (name: "Balance Control - Roll Over", type:"mat"),
    (name: "Push Ups", type:"mat"),
]
