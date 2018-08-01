//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController {
    
    @IBOutlet weak var contentTextField: UITextView!
    @IBOutlet weak var titleTextView: UITextField!
    
    var note: Note?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let note = note{
            titleTextView.text = note.title
            contentTextField.text = note.content
        }else{
            titleTextView.text = ""
            contentTextField.text = ""
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {return}
        
        switch identifier{
        case "save" where note == nil:
            let note = CoredDataHelper.newNote()
            
            note.title = titleTextView.text ?? ""
            note.content = contentTextField.text ?? ""
            note.modificationTime = Date()
            
            CoredDataHelper.saveNote()
            
        case "save" where note != nil:
            note?.title = titleTextView.text ?? ""
            note?.content = contentTextField.text ?? ""
            
            CoredDataHelper.saveNote()
            
        case "cancel":
            print("cancel bar button was tapped")
        default:
            print("unexpected segue identifier")
        }
    }
}
