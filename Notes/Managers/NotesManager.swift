//
//  NotesManager.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import Foundation

class NotesManager {
    
    static let shared = NotesManager()
    
    func getNotes() -> [Notes] {
        guard let note = UserDefaults.standard.object(forKey: "Note") as? Data else {
            return [Notes]()
        }
        
        if let loadedNote = try? JSONDecoder().decode([Notes].self, from: note) {
            return loadedNote
        }
        
        return [Notes]()
    }
    
    func setNote(notes: [Notes]) {
        encodeNotes(notes: notes)
    }
    
    func editNote(notes: Notes, atIndex: Int) {
        var notesArray = getNotes()
        notesArray[atIndex] = notes
        
        encodeNotes(notes: notesArray)
    }
    
    func encodeNotes(notes: [Notes]) {
        let encoded = try? JSONEncoder().encode(notes)
        UserDefaults.standard.set(encoded, forKey: "Note")
    }
}
