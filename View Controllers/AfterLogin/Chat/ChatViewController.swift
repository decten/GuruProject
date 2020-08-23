//
//  ChatViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/16.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
//여유가 된다면 채팅방 이름을 사용자명으로 변경하자!!!!!!!!!!!!!!!!

let baseRef = Database.database().reference()
let userRef = baseRef.child("user") //사용자
let roomRef = baseRef.child("room") //채팅방
let messageRef = baseRef.child("message") //말풍선


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addButton(_ sender: Any) {
        pushView(controller: "UserListViewController")
    }
    
    var rooms: [Room] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "chatting", sender: rooms[indexPath.row].key)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = rooms[indexPath.row].name
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismiss(animated: false, completion: nil)
        tableView.delegate = self
        tableView.dataSource = self
        fetchRoom()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
       if segue.identifier == "chatting"{
            let chatVC = segue.destination as! ChatDetailViewController
            chatVC.roomKey = sender as? String
        }
    }
    
    
      func fetchRoom(){
        if let uid = Auth.auth().currentUser?.uid{
            baseRef.child("user").child(uid).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                if let dict = snapshot.value as? Dictionary<String,Int>{
                    for (key, _) in dict{
                        roomRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                            if let data = snapshot.value as? Dictionary<String,AnyObject>{
                                let rm = Room(key: key, data: data)
                                self.rooms.append(rm)
                                
                                DispatchQueue.main.async {
                                    self.tableView.reloadData()
                                }
                            }
                        })
                    }
                }
            })
        }
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
}
