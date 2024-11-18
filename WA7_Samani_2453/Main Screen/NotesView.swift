//
//  NotesView.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class NotesView: UIView {

    var tableViewNote: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        //MARK: initializing a TableView...
        setupTableViewNote()
        initConstraints()
    }
    
    func setupTableViewNote(){
        tableViewNote = UITableView()
        tableViewNote.register(TableViewNoteCell.self, forCellReuseIdentifier: "notes")
        tableViewNote.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(tableViewNote)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            tableViewNote.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 8),
            tableViewNote.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            tableViewNote.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 8),
            tableViewNote.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -8),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
