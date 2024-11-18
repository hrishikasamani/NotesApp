//
//  UserDetailsViewController.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit
import Alamofire

class UserDetailsViewController: UIViewController {

    let userDetails = UserDetailsView()
    var currentUser: Users = Users()
    let defaults = UserDefaults.standard
    var delegate:ViewController!
    
    override func loadView() {
        view = userDetails
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(userDidLogin),
            name: .userDidLogin,
            object: nil
        )
        //profileDetails(currentUser: self.currentUser)
        profileDetails()
        userDetails.logoutButton.addTarget(self, action: #selector(onButtonLogoutTapped), for: .touchUpInside)
        // Do any additional setup after loading the view.
    }
    
    @objc func userDidLogin(_ notification: Notification) {
        if let token = notification.userInfo?["token"] as? String {
            print("Token received in UserDetails: \(token)")
            self.currentUser.token = token
            profileDetails()
        }
    }
    
    @objc func onButtonLogoutTapped() {
        currentUser = Users()
        let loginScreen = LoginViewController()
        
        // remove locally stored token
        self.defaults.removeObject(forKey: "notesAppApiKey")
        navigationController?.setViewControllers([loginScreen], animated: true)
    }
    
    //func profileDetails(currentUser: Users){
        func profileDetails(){
        print("Token being used: \(self.currentUser.token ?? "No token")")
        
        if let url = URL(string: UsersAPI.usersURL+"me"){
            AF.request(url, method:.get,
                       encoding: URLEncoding.queryString,
                       headers: [
                        "x-access-token": self.currentUser.token ?? ""
                          ])
                .responseData(completionHandler: { response in
                
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                            case 200...299:
                            print("success to fetch user details")
                            //MARK: the request was valid 200-level...
                                //MARK: show alert with details...
                                let decoder = JSONDecoder()
                                do{
                                    let receivedData =
                                        try decoder
                                        .decode(Users.self, from: data)
                                    DispatchQueue.main.async {
                                    self.userDetails.name.text = "Name: \(receivedData.name ?? "Missing")"
                                    self.userDetails.email.text = "Email: \(receivedData.email ?? "Missing")"
                                    }
                                    
                                }catch{
                                    print("JSON couldn't be decoded.")
                                }
                                break
                    
                            case 400...499:
                            //MARK: the request was not valid 400-level...
                                print(data)
                                break
                    
                            default:
                            //MARK: probably a 500-level error...
                                print(data)
                                break
                    
                        }
                    }
                    break
                    
                case .failure(let error):
                    //MARK: there was a network error...
                    print(error)
                    break
                }
            })
        }
    }
    
    func showAlert(message: String){
        let alert = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
    }
}
