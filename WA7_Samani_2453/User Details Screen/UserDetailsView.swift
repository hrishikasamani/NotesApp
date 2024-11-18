//
//  UserDetailsView.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class UserDetailsView: UIView {
    
    var contentWrapper:UIScrollView!
    var name: UILabel!
    var email: UILabel!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setupContentWrapper()
        setupName()
        setupEmail()
        setupLogoutButton()
        initConstraints()
    }
        
    func setupContentWrapper(){
        contentWrapper = UIScrollView()
        contentWrapper.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(contentWrapper)
    }
    
    func setupName() {
        name = UILabel()
        name.font = UIFont.boldSystemFont(ofSize: 20)
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func setupEmail(){
        email = UILabel()
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
        
    func setupLogoutButton() {
        logoutButton = UIButton()
        logoutButton.setTitle("Logout", for: .normal)
        logoutButton.setTitleColor(.systemRed, for: .normal)
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(logoutButton)
    }

    func initConstraints() {
        NSLayoutConstraint.activate([
            contentWrapper.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            contentWrapper.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            contentWrapper.widthAnchor.constraint(equalTo:self.safeAreaLayoutGuide.widthAnchor),
            contentWrapper.heightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.heightAnchor),
            
            
            // labelName constraints
            name.topAnchor.constraint(equalTo: contentWrapper.topAnchor, constant: 16),
            name.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            
            // labelEmail constraints
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 32),
            email.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),

            logoutButton.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 32),
            logoutButton.centerXAnchor.constraint(equalTo: contentWrapper.centerXAnchor),
            
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
