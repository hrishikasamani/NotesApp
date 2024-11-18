//
//  LoginViewController.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    let loginScreen = LoginView()
    var receivedData: Users?
    var currentUser: Users = Users()
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = loginScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)
        
        loginScreen.registerButton.addTarget(self, action: #selector(onRegisterButtonTapped), for: .touchUpInside)
        
        loginScreen.loginButton.addTarget(self, action: #selector(onLoginButtonTapped), for: .touchUpInside)
        
        checkToken()
    }

    @objc func onRegisterButtonTapped() {
        let registerViewController = RegisterViewController()
        registerViewController.modalPresentationStyle = .fullScreen
        self.present(registerViewController, animated: true, completion: nil)
        print("Register button tapped.")
    }
    
    @objc func onLoginButtonTapped() {
        guard let email = loginScreen.email.text, !email.isEmpty,
              let password = loginScreen.password.text, !password.isEmpty else {
            showAlert(title: "Input Required", message: "Please fill in both email and password.")
            return
        }
        
        if validateEmail(email) && validatePassword(password) {
            // Perform the login API call
            performLogin(email: email, password: password)
        } else {
            showAlert(title: "Invalid Input", message: "Please enter a valid email and a strong password.")
        }
    }

    func performLogin(email: String, password: String) {
    if let url = URL(string: UsersAPI.usersURL + "login"){
        AF.request(url, method: .post, parameters: ["email":email, "password":password])
        .responseData(completionHandler: { response in
        //MARK: retrieving the status code...
        let status = response.response?.statusCode
        switch response.result{
        case .success(let data):
            print(data)
            //MARK: there was no network error...
            
            //MARK: status code is Optional, so unwrapping it...
        if let uwStatusCode = status{
        switch uwStatusCode{
            case 200...299:
            //MARK: the request was valid 200-level...
                let decoder = JSONDecoder()
                do{
                    self.receivedData = try decoder
                        .decode(Users.self, from: data)
                    self.receivedData?.email = email
                        
                        if let token = self.receivedData?.token{
                            self.defaults.set(token, forKey: "notesAppApiKey")
                            NotificationCenter.default.post(
                                    name: .userDidLogin,
                                    object: nil,
                                    userInfo: ["token": token]
                                )
                                        
                       
                        self.dismiss(animated: true) {
                            // Initialize the main view controller and embed it in a new navigation controller
                            let mainViewController = ViewController()
                            mainViewController.currentUser = self.receivedData!
                            
                            let mainNavigationController = UINavigationController(rootViewController: mainViewController)
                            
                            if let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate,
                               let window = sceneDelegate.window {
                                window.rootViewController = mainNavigationController
                                window.makeKeyAndVisible()
                            }
                        }
                            
                    }
                }catch{
                    print("4::",error)
                }
                break
    
                case 400...499:
                //MARK: the request was not valid 400-level...
                self.showAlert(title: "Error",message: "Email or password is incorrect")
                    break
        
                default:
                //MARK: probably a 500-level error...
                    self.showAlert(title: "Error",message: "An unexpected error occurred. Please try again later.")
                    break
                
                    }
                }
            break
            
            case .failure(let error):
                //MARK: there was a network error...
                print("1::",error)
                break
            }
        })
        }
    }
    // Email validation function
    private func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }

    // Password validation function
    private func validatePassword(_ password: String) -> Bool {
        return password.count >= 4 // You can adjust this to your criteria
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }

    private func checkToken() {
        if let apiKey = UserDefaults.standard.string(forKey: "notesAppApiKey") {
            // Token exists, meaning the user is logged in
            navigateToNotes()
        }
        else {
            // No saved token, user needs to log in
            print("No saved API key; user needs to log in.")
        }
    }
    
    private func navigateToNotes() {
        let notesViewController = ViewController()
        notesViewController.modalPresentationStyle = .fullScreen
        self.present(notesViewController, animated: true, completion: nil)
    }
}

