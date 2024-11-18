//
//  RegisterView.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class RegisterView: UIView {
    
    var registerLabel: UILabel!
    var name: UITextField!
    var email: UITextField!
    var password: UITextField!
    var signUpButton: UIButton!
    var dismissButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupRegisterLabel()
        setupName()
        setupEmail()
        setupPassword()
        setupSignUpButton()
        setupDismissButton()
        initConstraints()
    }
    func setupRegisterLabel() {
        registerLabel = UILabel()
        registerLabel.text = "Register"
        registerLabel.font = UIFont.boldSystemFont(ofSize: 18)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerLabel)
    }
    
    func setupName() {
        name = UITextField()
        name.placeholder = "Name"
        name.borderStyle = .roundedRect
        name.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(name)
    }
    
    func setupEmail(){
        email = UITextField()
        email.placeholder = "Email"
        email.borderStyle = .roundedRect
        email.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(email)
    }
    
    func setupPassword() {
        password = UITextField()
        password.placeholder = "Password"
        password.borderStyle = .roundedRect
        password.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(password)
    }
    
    func setupSignUpButton() {
        signUpButton = UIButton()
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.backgroundColor = .systemBlue
        signUpButton.layer.cornerRadius = 10
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(signUpButton)
    }
    
    func setupDismissButton() {
        dismissButton = UIButton()
        dismissButton.setTitle("Already have an account?", for: .normal)
        dismissButton.setTitleColor(.systemBlue, for: .normal)
        dismissButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(dismissButton)
    }

    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            registerLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            registerLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            name.topAnchor.constraint(equalTo: registerLabel.topAnchor, constant: 60),
            name.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            name.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            name.heightAnchor.constraint(equalToConstant: 40),
            
            email.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 20),
            email.self.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            email.self.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            email.self.heightAnchor.constraint(equalToConstant: 40),
            
            // Password field constraints
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            signUpButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            signUpButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            signUpButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            
            dismissButton.topAnchor.constraint(equalTo: signUpButton.bottomAnchor, constant: 20),
            dismissButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            dismissButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            dismissButton.heightAnchor.constraint(equalToConstant: 50),
            
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
