//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class ListNotesTableViewController: UITableViewController {
    
    var chronologicalOrder: Bool = true
    
    var notes = [Note]() {
        didSet{
            tableView.reloadData()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = CoredDataHelper.retrieveNotes()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        let note: Note
        if chronologicalOrder{
            note = notes[notes.count - 1 - indexPath.row]
        } else{
            note = notes[indexPath.row]
        }
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime?.convertToString() ?? "unknown"
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier{
        case "displayNote":
            print("Note cell tapped")
            
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            let note = notes[indexPath.row]
            
            let destination = segue.destination as! DisplayNoteViewController
            
            destination.note = note
            
        case "addNote":
            print("Create note bar button item tapped")
        default:
            print("Unexpected segue identifier")
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath){
        if editingStyle == .delete{
            let noteToDelete = notes[indexPath.row]
            CoredDataHelper.deleteNote(note: noteToDelete)
            
            notes = CoredDataHelper.retrieveNotes()
        }
    }
    @IBAction func reorderNotes(_ sender: Any) {
        chronologicalOrder = !chronologicalOrder
        tableView.reloadData()
    }
    
    @IBAction func unwindWidthSegue(_ segue: UIStoryboardSegue) {
        notes = CoredDataHelper.retrieveNotes()
    }
}
