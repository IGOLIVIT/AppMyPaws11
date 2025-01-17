//
//  EventsViewModel.swift
//  AppMyPaws
//
//  Created by IGOR on 10/01/2025.
//

import SwiftUI
import CoreData

final class EventsViewModel: ObservableObject {

    @Published var photos: [String] = ["p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12"]
    @Published var curPhoto = ""
    
    @Published var genders: [String] = ["Male", "Female"]
    @Published var selGen = ""

    @Published var isAdd: Bool = false
    @Published var isDetail: Bool = false
    @Published var isDelete: Bool = false
    
    @Published var evPet: String = ""
    @Published var evName: String = ""
    @Published var evDate: Date = Date()
    @Published var evTime: Date = Date()
    @Published var evPetPhoto: String = ""
    @Published var evDescr: String = ""

    @Published var events: [EventModel] = []
    @Published var selectedEvent: EventModel?

    func addEvent() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "EventModel", into: context) as! EventModel

        loan.evPet = evPet
        loan.evName = evName
        loan.evDate = evDate
        loan.evTime = evTime
        loan.evPetPhoto = evPetPhoto
        loan.evDescr = evDescr

        CoreDataStack.shared.saveContext()
    }

    func fetchEvents() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EventModel>(entityName: "EventModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.events = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.events = []
        }
    }

    @Published var peName: String = ""
    @Published var peAnim: String = ""
    @Published var peGen: String = ""
    @Published var peDate: Date = Date()
    @Published var peDescr: String = ""
    @Published var pePhoto: String = ""

    @Published var pets: [PetsModel] = []
    @Published var selectedPet: PetsModel?

    func addPet() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let loan = NSEntityDescription.insertNewObject(forEntityName: "PetsModel", into: context) as! PetsModel

        loan.peName = peName
        loan.peAnim = peAnim
        loan.peGen = peGen
        loan.peDate = peDate
        loan.peDescr = peDescr
        loan.pePhoto = pePhoto

        CoreDataStack.shared.saveContext()
    }

    func fetchPets() {

        let context = CoreDataStack.shared.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<PetsModel>(entityName: "PetsModel")

        do {

            let result = try context.fetch(fetchRequest)

            self.pets = result

        } catch let error as NSError {

            print("catch")

            print("Error fetching persons: \(error), \(error.userInfo)")

            self.pets = []
        }
    }
 
}
