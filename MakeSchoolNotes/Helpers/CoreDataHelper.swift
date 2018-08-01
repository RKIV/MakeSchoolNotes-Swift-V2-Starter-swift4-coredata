//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by Robert Keller on 7/3/18.
//  Copyright © 2018 MakeSchool. All rights reserved.
//

import Foundation
import UIKit
import CoreData

struct CoredDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    static func newNote() -> Note {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: context) as! Note
        
        return note
    }
    
    static func saveNote() {
        do {
            try context.save()
        } catch let error{
            print("Could not save \(error.localizedDescription)")
        }
    }
    
    static func deleteNote(note: Note) {
        context.delete(note)
    }
    
    static func retrieveNotes() -> [Note]{
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        do{
            let results = try context.fetch(fetchRequest)
            return results
        } catch let error{
            print("Could note fetch \(error.localizedDescription)")
            return []
        }
    }
}
