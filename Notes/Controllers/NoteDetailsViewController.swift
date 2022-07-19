//
//  NoteDetailsViewController.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import UIKit

class NoteDetailsViewController: UIViewController {

    weak var delegate: NoteManagingDelegate?
    var note: Notes!
    var formattedDate: String!
    var index = 0
    
    var noteTextfield: UITextField = {
        let textField = UITextField()
        let paddingView: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 20))
        textField.leftView = paddingView
        textField.leftViewMode = .always
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
        textField.placeholder = "Enter note title"
        textField.isEnabled = false
        textField.resignFirstResponder()

        return textField
    }()
    
    var noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderColor = UIColor.black.cgColor
        textView.layer.borderWidth = 1
        textView.isEditable = false

        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        noteTextfield.text = note.noteTitle
        noteTextView.text = note.noteTextViewText
    }
    
    @objc func editNote(_ sender: Any) {
        noteTextfield.isEnabled = !noteTextfield.isEnabled
        noteTextView.isEditable = !noteTextView.isEditable
        
        guard let textfieldText = noteTextfield.text, textfieldText.count > 0 else { return }
        guard let textViewText = noteTextView.text, textViewText.count > 0 else { return }

        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YY/MM/dd"
        formattedDate = dateFormatter.string(from: date)

        addDoneButton()
    }
    
    func addDoneButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneBtnClicked(_:)))
    }
    
    @objc func doneBtnClicked(_ sender: Any) {
        guard let textfieldText = noteTextfield.text, textfieldText.count > 0 else { return }
        guard let textViewText = noteTextView.text, textViewText.count > 0 else { return }
        
        noteTextfield.isEnabled = !noteTextfield.isEnabled
        noteTextView.isEditable = !noteTextView.isEditable
        
        if textfieldText != self.note.noteTitle || textViewText != self.note.noteTextViewText {
            let newNote = Notes(noteTitle: textfieldText, noteTextViewText: textViewText, noteDate: formattedDate)
            delegate?.editNote(note: newNote, index: index)
            self.navigationController?.popViewController(animated: true)
        }
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
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editNote(_:)))
    }
}
