//
//  ViewController.swift
//  WA7_Samani_2453
//
//  Created by Hrishika Samani on 11/2/24.
//

import UIKit
import Alamofire

class ViewController: UIViewController{
    
    let mainScreen = NotesView()
    let notificationCenter = NotificationCenter.default
    var notes = [Note]()
    let defaults = UserDefaults.standard
    var currentUser: Users = Users()
    
    override func loadView() {
        view = mainScreen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Notes"
        mainScreen.tableViewNote.dataSource = self
        mainScreen.tableViewNote.delegate = self
        mainScreen.tableViewNote.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped)
        )
        let userButton = UIBarButtonItem(
            image: UIImage(systemName: "person.circle"),
            style: .plain,
            target: self,
            action: #selector(onUserButtonTapped)
        )
        navigationItem.leftBarButtonItem = userButton
        // Check if the token exists
        checkForToken()
        
        notificationCenter.addObserver(
            self,
            selector: #selector(handleNoteAdded(notification:)),
            name: Notification.Name("noteAdded"),
            object: nil)
    }
    
    @objc func onUserButtonTapped(){
        let detailsViewController = UserDetailsViewController()
        detailsViewController.currentUser = self.currentUser
        navigationController?.pushViewController(detailsViewController, animated: true)
    }
    
    @objc func handleNoteAdded(notification: Notification) {
        getAllNotes()
    }
    
    @objc func onAddBarButtonTapped(){
        let addNewNote = AddNewNoteViewController()
        addNewNote.currentUser = self.currentUser
        addNewNote.delegate = self
        navigationController?.pushViewController(addNewNote, animated: true)
    }
    
    private func checkForToken() {
        if let token = UserDefaults.standard.string(forKey: "notesAppApiKey") {
            print("Token found. Fetching notes.")
            currentUser.token = UserDefaults.standard.string(forKey: "notesAppApiKey")
            getAllNotes()
        } else {
            print("Token not found. Redirecting to login.")
            navigateToLogin()
        }
    }
    
    private func navigateToLogin() {
        let loginVC = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginVC)
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
    }
    
    func getAllNotes() {
        print(currentUser.token ?? "")
        if let url = URL(string: NotesAPI.notesURL + "getall"){
            AF.request(url, method: .get, headers: [
                "x-access-token": currentUser.token ?? ""
            ]).responseData(completionHandler: { response in
                //MARK: retrieving the status code...
                let status = response.response?.statusCode
                switch response.result{
                case .success(let data):
                    //MARK: there was no network error...
                    if let jsonString = String(data: data, encoding: .utf8){
                        print("Response data: \(jsonString)")
                    }
                    //MARK: status code is Optional, so unwrapping it...
                    if let uwStatusCode = status{
                        switch uwStatusCode{
                        case 200...299:
                            //MARK: the request was valid 200-level...
                            self.notes.removeAll()
                            let decoder = JSONDecoder()
                            do{
                                let receivedData =
                                try decoder
                                    .decode(Notes.self, from: data)
                                
                                for item in receivedData.notes{
                                    let note = Note(_id: item._id, text: item.text)
                                    self.notes.append(note)
                                }
                                self.mainScreen.tableViewNote.reloadData()
                            }catch{
                                print("JSON couldn't be decoded.")
                            }
                            break
                            
                        case 400...499:
                            //MARK: the request was not valid 400-level...
                            print("1..")
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                   let message = json["message"] as? String {
                                    print("Client error:", message)
                                } else {
                                    print("Client error: Unexpected JSON structure")
                                }
                            } catch {
                                if let errorMessage = String(data: data, encoding: .utf8) {
                                    print("Client error (plain text):", errorMessage)
                                } else {
                                    print("Client error: Could not parse error message")
                                }
                            }
                            break
                            
                        default:
                            //MARK: probably a 500-level error...
                            print("2..")
                            do {
                                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                                   let message = json["message"] as? String {
                                    print("Client error:", message)
                                } else {
                                    print("Client error: Unexpected JSON structure")
                                }
                            } catch {
                                if let errorMessage = String(data: data, encoding: .utf8) {
                                    print("Client error (plain text):", errorMessage)
                                } else {
                                    self.showAlert(title: "Error!",message: "Client error: Could not parse error message")
                                }
                            }
                            break
                            
                        }
                    }
                    break
                    
                case .failure(let error):
                    //MARK: there was a network error...
                    self.showAlert(title: "Error!",message: "")
                    break
                }
            })
        }
    }
    
    //MARK: add a new Note call: add endpoint...
    func deleteNoteWithId(noteId: String?){
        if let url = URL(string: NotesAPI.notesURL+"delete"){
            
            AF.request(url, method:.post, parameters:
                        [
                            "id": noteId ?? ""
                        ],
                       headers: [
                           "x-access-token": currentUser.token ?? ""
                           ])
                .responseString(completionHandler: { response in
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
                                    self.getAllNotes()
                                    break
                        
                                case 400...499:
                                //MARK: the request was not valid 400-level...
                                    self.showAlert(title: "Error!",message: "API Error: \(data)")
                                    break
                        
                                default:
                                //MARK: probably a 500-level error...
                                    self.showAlert(title: "Error!",message: "API Error: \(data)")
                                    break
                            }
                        }
                        break
                        
                    case .failure(let error):
                        //MARK: there was a network error...
                        self.showAlert(title: "Error!", message: "Network Error: \(error)")
                        break
                    }
                })
        }else{
            showAlert(title: "Error!",message: "Invalid URL call")
        }
    }
    
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "notes", for: indexPath) as! TableViewNoteCell
        cell.labelText.text = notes[indexPath.row].text
        
        let buttonDelete = UIButton(type: .system)
        buttonDelete.setImage(UIImage(systemName: "trash"), for: .normal)
        buttonDelete.tintColor = .red
        buttonDelete.sizeToFit()

        buttonDelete.addTarget(self, action: #selector(deleteSelectedFor(_:)), for: .touchUpInside)
        buttonDelete.tag = indexPath.row

        cell.accessoryView = buttonDelete
        return cell
    }
    @objc func deleteSelectedFor(_ sender: UIButton) {
        print("Note deleted")
        let row = sender.tag
        let alert = UIAlertController(title: "Delete Note",
                                      message: "Are you sure you want to delete this note?",
                                      preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.deleteNoteWithId(noteId: self.notes[row]._id)
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(alert, animated: true, completion: nil)
    }

}

