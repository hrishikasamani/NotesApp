//
//  AddNewNoteController.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit
import Alamofire

class AddNewNoteViewController: UIViewController {
    
    var delegate:ViewController!
    let addNewNoteScreen = AddNewNoteView()
    var currentUser: Users = Users()
    
    override func loadView() {
        view = addNewNoteScreen
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add a New Note"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveButtonTapped)
        )
    }
    
    @objc func onSaveButtonTapped() {
        if let text = addNewNoteScreen.textField.text, !text.isEmpty {
            print("Attempting to save note: \(text)")
            print(self.currentUser)
            addNewNote(text: text)
        } else {
            showAlert(message: "Please enter a note.")
        }
    }
    
    func addNewNote(text: String) {
        if let url = URL(string: NotesAPI.notesURL+"post"){
            
            print("Using URL: \(url.absoluteString)")
            print("Token being used: \(currentUser.token ?? "No token")")
            
            let parameters: [String: String] = ["text": text]
            AF.request(url,
                      method: .post,
                      parameters: parameters,
                      encoding: JSONEncoding.default,
                      headers: [
                        "x-access-token": currentUser.token ?? "",
                        "Content-Type": "application/json"
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
                                //MARK: the request was valid 200-level...
                                self.delegate.getAllNotes()
                                self.clearAddViewFields()
                                print("Note added successfully.")
                                NotificationCenter.default.post(name: Notification.Name("noteAdded"), object: text)
                            
                                self.navigationController?.popViewController(animated: true)
                                
                                break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    self.showAlert(message: "API 404 Error: \(data)")
                                    break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    self.showAlert(message: "API Error: \(data)")
                                    break
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        self.showAlert(message: "Network Error: \(error)")
                        break
                    }
                })
        }else{
            showAlert(message: "Invalid URL call")
        }
    }
        
    func clearAddViewFields() {
        addNewNoteScreen.textField.text = ""
    }
        
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}
