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
        self.deleteAll()
        self.seedExercises()
        self.seedWorkouts()
        self.seedClients()
        self.seedClientSessions()
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
    
    
    func seedWorkouts() {
        let allMatExercises: [Exercise] = findAllEntities(type: "Exercise")
        let newMatWorkout = Workout(context: self.context)
        newMatWorkout.id = UUID()
        newMatWorkout.name = "Pilates Mat"
        newMatWorkout.exercises = NSSet(array: allMatExercises)
    }
    
    
    func seedClients() {
        let allWorkouts: [Workout] = findAllEntities(type: "Workout")
        let newClient = Client(context: self.context)
        newClient.id = UUID()
        newClient.name = "Sample Client"
        newClient.workouts = NSSet(array: allWorkouts)
    }
    
    func seedClientSessions() {
        let allClients: [Client] = findAllEntities(type: "Client")
        let allExercises: [Exercise] = findAllEntities(type: "Exercise")
        let newSession = WorkoutSession(context: self.context)
        newSession.id = UUID()
        newSession.completedOn = Date()
        newSession.exercises = NSSet(array:allExercises)
        newSession.title = "Sample Session"
        
        for c in allClients {
            c.workoutSessions = [newSession]
        }
    }
    
    func workout() -> Workout {
        let ex1 = Exercise.init(context: self.context)
        ex1.name = "Sample Exercise 1"
        ex1.id = UUID()
        let ex2 = Exercise.init(context: self.context)
        ex2.name = "Sample Exercise 2"
        ex2.id = UUID()
        
        let workout = Workout(context: self.context)
        workout.addToExercises(ex1)
        workout.addToExercises(ex2)
        workout.name = "Sample Workout"
        workout.id = UUID()
        
        return workout
    }
    
    func client() -> Client {
        let client = Client(context: self.context)
        client.name = "Sample Client"
        client.addToWorkouts(NSSet(array: self.findAllEntities(type: "Workout")))
        client.addToWorkoutSessions(NSSet(array: [self.workoutSession()]))
        
        return client
    }
    
    func workoutSession() -> WorkoutSession {
        let allExercises: [Exercise] = findAllEntities(type: "Exercise")
        let newSession = WorkoutSession(context: self.context)
        newSession.id = UUID()
        newSession.completedOn = Date()
        newSession.exercises = NSSet(array:allExercises)
            
        return newSession
    }
    
    func exercise() -> Exercise {
        let exercise = Exercise(context: self.context)
        exercise.name = "Sample Exercise!"
        exercise.id = UUID()

        return exercise
    }
    
    
    func printExercises() {
        let allExercises: [Exercise] = findAllEntities(type: "Exercise")
        for exercise in allExercises {
            print("\(exercise.name ?? "") -- Type: \(exercise.type ?? "") -- \(exercise.order)")
        }
    }
    
    func printWorkouts() {
        let workouts: [Workout] = findAllEntities(type: "Workout")
        for workout in workouts {
            print("Workout: \(workout.wrappedName)")
        }
    }
    
    func printClients() {
        let clients: [Client] = findAllEntities(type: "Client")
        for client in clients {
            print("Client: \(client.wrappedName)")
        }
    }
    
    func deleteAll() {
        let fetchExercises = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        let deleteExercises = NSBatchDeleteRequest(fetchRequest: fetchExercises)
        
        let fetchWorkouts = NSFetchRequest<NSFetchRequestResult>(entityName: "Workout")
        let deleteWorkouts = NSBatchDeleteRequest(fetchRequest: fetchWorkouts)
        
        let fetchClients = NSFetchRequest<NSFetchRequestResult>(entityName: "Client")
        let deleteClients = NSBatchDeleteRequest(fetchRequest: fetchClients)
        
        let fetchSessions = NSFetchRequest<NSFetchRequestResult>(entityName: "WorkoutSession")
        let deleteWorkoutSessions = NSBatchDeleteRequest(fetchRequest: fetchSessions)
        do {
            try self.context.execute(deleteExercises)
            try self.context.execute(deleteWorkouts)
            try self.context.execute(deleteClients)
            try self.context.execute(deleteWorkoutSessions)
        } catch{
            print(error)
        }
    }
    
    func findAllEntities<T:NSManagedObject>(type: String) -> [T] {
        let req = NSFetchRequest<T>(entityName:type)
        req.sortDescriptors = []
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
