//
//  ViewController.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import UIKit

struct Notes {
    let noteTitle: String
    let noteTextViewText: String
    let noteDate: String
}

protocol AddNewNote: AnyObject {
    func addNewNote(newNote: Notes)
}

class NotesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var notes: [Notes]? {
        didSet {
            var _ = notes?.sorted { $0.noteDate < $1.noteDate }
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createNewNotes(_:)))
    }
    
    @objc func createNewNotes(_ sender: Any) {
        let noteDetailsVC = NoteDetailsViewController()
        noteDetailsVC.delegate = self
        self.navigationController?.pushViewController(noteDetailsVC, animated: true)
    }

    override func viewDidAppear(_ animated: Bool) {
        print(notes)
    }

}

extension NotesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        notes?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotesListCellIdentifier") as! NotesListCell
        if let notes = self.notes {
            cell.setCellElements(notes: notes[indexPath.row])
        }
        return cell
    }
}

extension NotesViewController: AddNewNote {
    func addNewNote(newNote: Notes) {
            self.notes?.append(newNote)
            self.tableView.reloadData()
    }
}




