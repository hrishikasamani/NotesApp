//
//  RegisterViewController.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit
import Alamofire

class RegisterViewController: UIViewController {
    
    let registerView = RegisterView()
    let defaults = UserDefaults.standard
    
    override func loadView() {
        view = registerView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tapRecognizer)
        
        registerView.dismissButton.addTarget(self, action: #selector(dismissButtonTapped), for: .touchUpInside)
        
        registerView.signUpButton.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)

    }
    
    @objc func hideKeyboardOnTap(){
        //MARK: removing the keyboard from screen...
        view.endEditing(true)
    }
    
    @objc func signUpButtonTapped() {
        // Validate the input fields
        guard let name = registerView.name.text, !name.isEmpty,
              let email = registerView.email.text, isValidEmail(email),
              let password = registerView.password.text, isValidPassword(password) else {
            // Show an alert if validation fails
            showAlert(message: "Please enter valid name, email, and password.")
            return
        }
        registerUser(name: name, email: email, password: password)
    }
    func isValidPassword(_ password: String) -> Bool {
        return password.count >= 4 // You can adjust this to your criteria
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Invalid Input", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    // MARK: Register User API Call
    func registerUser(name: String, email: String, password: String) {
        if let url = URL(string: UsersAPI.usersURL+"register"){
            AF.request(url, method: .post, parameters: ["name":name, "email":email, "password":password])
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
                                var receivedData = try decoder
                                    .decode(Users.self, from: data)
                                receivedData.email = email
                                receivedData.name = name
                                let token = receivedData.token
                                self.defaults.set(token, forKey: "notesAppApiKey")
                                
                                print("Registration successful")
                                
                                self.dismiss(animated: true) {
                                    let mainViewController = ViewController()
                                    mainViewController.currentUser = receivedData
                                    
                                    self.navigationController?.setViewControllers([mainViewController], animated: true)
                                }
                                }catch{
                                    print("4::",error)
                                }
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                self.showAlert(message: "Recheck your name, email and password.")
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                self.showAlert(message: "User already exists.")
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
        
    @objc func dismissButtonTapped() {
        // Dismiss the view controller
        self.dismiss(animated: true, completion: nil)
    }
    

}
