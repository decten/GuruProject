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
let roomRef = baseRef.child("room") //채팅방
let messageRef = baseRef.child("message") //말풍선


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!

    
    var rooms: [room] = []
    
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
        tableView.delegate = self
        tableView.dataSource = self
        fetchList()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "chatting"{
            let chatVC = segue.destination as! ChatDetailViewController
            chatVC.roomKey = sender as? String
        }
    }
    
    
    func fetchList(){}
    
}
