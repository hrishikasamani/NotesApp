//
//  LoginView.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit

class LoginView: UIView {
    
    var loginLabel: UILabel!
    var email: UITextField!
    var password: UITextField!
    var loginButton: UIButton!
    var registerLabel: UILabel!
    var registerButton: UIButton!
    var registerLabel2: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        setupLoginLabel()
        setupEmail()
        setupPassword()
        setupLoginButton()
        setupRegisterLabel()
        setupRegisterButton()
        setupRegisterLabel2()
        initConstraints()
    }
    
    func setupLoginLabel() {
        loginLabel = UILabel()
        loginLabel.text = "Login"
        loginLabel.font = UIFont.boldSystemFont(ofSize: 18)
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginLabel)
    }
    
    func setupEmail() {
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
    
    func setupLoginButton() {
        loginButton = UIButton()
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = .systemGreen
        loginButton.layer.cornerRadius = 10
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(loginButton)
    }
    
    func setupRegisterLabel() {
        registerLabel = UILabel()
        registerLabel.text = "Don't have an account?"
        registerLabel.font = UIFont.boldSystemFont(ofSize: 16)
        registerLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerLabel)
    }
    
    func setupRegisterButton() {
        registerButton = UIButton()
        registerButton.setTitle("Register", for: .normal)
        registerButton.setTitleColor(.blue, for: .normal)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerButton)
    }
    
    func setupRegisterLabel2() {
        registerLabel2 = UILabel()
        registerLabel2.text = "now!"
        registerLabel2.font = UIFont.boldSystemFont(ofSize: 16)
        registerLabel2.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(registerLabel2)
    }

    
    func initConstraints() {
        NSLayoutConstraint.activate([
            
            loginLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10),
            loginLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            email.topAnchor.constraint(equalTo: loginLabel.topAnchor, constant: 60),
            email.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            email.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            email.heightAnchor.constraint(equalToConstant: 40),
            
            // Password field constraints
            password.topAnchor.constraint(equalTo: email.bottomAnchor, constant: 20),
            password.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            password.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            password.heightAnchor.constraint(equalToConstant: 40),
            
            // Login button constraints
            loginButton.topAnchor.constraint(equalTo: password.bottomAnchor, constant: 20),
            loginButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            loginButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 50),
            
            // Register label constraints
            registerLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            
            // Register button constraints
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 13),
            registerButton.leadingAnchor.constraint(equalTo: registerLabel.trailingAnchor, constant: 8),
            
            registerLabel2.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 20),
            registerLabel2.leadingAnchor.constraint(equalTo: registerButton.trailingAnchor, constant: 4),
        ])
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
