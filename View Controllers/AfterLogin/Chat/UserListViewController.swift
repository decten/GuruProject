//
//  UserListViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/22.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import Firebase

class UserListViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBAction func cancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBOutlet weak var tableview: UITableView!
    var chatroomVC: ChatViewController?
    var userList: [User] = []
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = userList[indexPath.row].userName
        cell.detailTextLabel?.text = userList[indexPath.row].email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let ref = roomRef.childByAutoId()
        ref.child("name").setValue(userList[indexPath.row].userName as String)
        dismiss(animated: true) {
            if let chatroomVC = self.chatroomVC{
                chatroomVC.performSegue(withIdentifier: "chatting", sender: ref.key)
            }
        }
        return
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        fetchUserList()
    }
    
    
    
    
    func fetchUserList(){
        userRef.observeSingleEvent(of: .value) { (snapshot) in
            if let data = snapshot.value as? Dictionary<String,AnyObject>, let uid = Auth.auth().currentUser?.uid{
                for (key, data) in data{
                    if uid != key{
                        if let userData = data as? Dictionary<String, AnyObject>{
                            let userName = userData["name"] as! String
                            let email = userData["email"] as! String
                            let user = User(password: uid, email: email, userName: userName)
                            self.userList.append(user)
                            
                            DispatchQueue.main.async {
                                self.tableview.reloadData()
                            }
                        }
                    }
                }
            }
        }
    }
    
}
