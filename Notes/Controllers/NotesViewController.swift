//
//  NotesViewController.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import UIKit

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes: [Notes] {
        get {
            var localStorageNotes = NotesManager.shared.getNotes()
            localStorageNotes.sort(by: { (s1, s2) -> Bool in
                return s1.noteDate < s2.noteDate
            })
            return localStorageNotes
        }
        set {
            NotesManager.shared.setNote(notes: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NotesListCell", bundle: nil), forCellReuseIdentifier: "NotesListCellIdentifier")
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNotes(_:)))
        title = "Notes"
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @objc func createNewNotes(_ sender: Any) {
        let addNewNoteVC = AddNewNoteViewController()
        addNewNoteVC.delegate = self
        self.navigationController?.pushViewController(addNewNoteVC, animated: true)
    }
}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCellIdentifier") as! NotesListCell
            cell.setCellElements(notes: notes[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailsVC = NoteDetailsViewController()
        detailsVC.note = self.notes[indexPath.row]
        detailsVC.index = indexPath.row
        detailsVC.delegate = self
        self.navigationController?.pushViewController(detailsVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}

extension NotesViewController: NoteManagingDelegate {
    func addNewNote(newNote: Notes) {
        DispatchQueue.main.async {
            self.notes.append(newNote)
            self.tableView.reloadData()
        }
    }
    
    func editNote(note: Notes, index: Int) {
        DispatchQueue.main.async {
            NotesManager.shared.editNote(notes: note, atIndex: index)
            self.tableView.reloadData()
        }
    }
}
