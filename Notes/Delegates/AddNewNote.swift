//
//  AddNewNote.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import Foundation

protocol NoteManagingDelegate: AnyObject {
    func addNewNote(newNote: Notes)
    func editNote(note: Notes, index: Int)
//    func removeNote(note: Notes, index: Int)
}
