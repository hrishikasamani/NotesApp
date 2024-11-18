//
//  AddNewNoteView.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class AddNewNoteView: UIView {

    var textField: UITextField!

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        setuptextField()
        initConstraints()
    }
    
    func setuptextField(){
        textField = UITextField()
        textField.placeholder = "Type here...."
        textField.borderStyle = .roundedRect
        textField.autocapitalizationType = .none
        textField.setContentHuggingPriority(.defaultLow, for: .horizontal)
        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        textField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(textField)
    }
    
    func initConstraints(){
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 32),
            textField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 40),
            textField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -40),
            
        ])
    }
    
    //MARK: unused methods...
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
