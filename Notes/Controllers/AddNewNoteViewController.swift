//
//  NoteDetailsViewController.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import UIKit

class NoteDetailsViewController: UIViewController {
    
    weak var delegate: AddNewNote?
    var newNote: Notes!
    
    var noteTextfield: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2
        textField.placeholder = "Enter note title"
        return textField
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 2
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    @objc func createNewNotes(_ sender: Any) {
        guard let textfieldText = noteTextfield.text, textfieldText.count > 0 else { return }
        guard let textViewText = noteTextView.text, textViewText.count > 0 else { return }

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        let formattedDate = dateFormatter.string(from: date)

        let newNote = Notes(noteTitle: textfieldText, noteTextViewText: textViewText, noteDate: formattedDate)
        delegate?.addNewNote(newNote: newNote)
        self.navigationController?.popViewController(animated: true)
    }

    func setupUI() {
        view.addSubview(noteTextfield)
        view.addSubview(noteTextView)
        
        noteTextfield.layer.cornerRadius = 8
        noteTextView.layer.cornerRadius = 8

        noteTextfield.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        noteTextfield.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        noteTextfield.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        noteTextfield.heightAnchor.constraint(equalToConstant: 50).isActive = true

        noteTextView.topAnchor.constraint(equalTo: noteTextfield.bottomAnchor, constant: 70).isActive = true
        noteTextView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -24).isActive = true
        noteTextView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 24).isActive = true
        noteTextView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(createNewNotes(_:)))
    }
}
