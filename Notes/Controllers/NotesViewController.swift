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
            return NotesManager.shared.getNotes()
        }
        set {
            NotesManager.shared.setNote(notes: newValue)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "NotesListCell", bundle: nil), forCellReuseIdentifier: "NotesListCellIdentifier")
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNotes(_:)))
    }
    
    @objc func createNewNotes(_ sender: Any) {
        let noteDetailsVC = NoteDetailsViewController()
        noteDetailsVC.delegate = self
        self.navigationController?.pushViewController(noteDetailsVC, animated: true)
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
}

extension NotesViewController: AddNewNote {
    func addNewNote(newNote: Notes) {
        DispatchQueue.main.async {
            self.notes.append(newNote)
            NotesManager.shared.setNote(notes: self.notes)
            self.tableView.reloadData()
        }
    }
}
