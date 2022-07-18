//
//  NotesListCell.swift
//  Notes
//
//  Created by Miran Hrupački on 18.07.2022..
//

import UIKit

class NotesListCell: UITableViewCell {
    
    @IBOutlet weak var noteTitle: UILabel!
    @IBOutlet weak var dateOfCreation: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCellElements(notes: Notes) {
        self.noteTitle.text = notes.noteTitle
        self.dateOfCreation.text = notes.noteDate
    }
}
