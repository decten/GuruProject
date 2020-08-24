//
//  ChatDetailViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/19.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ChatDetailViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    
    @IBOutlet weak var item: UINavigationItem!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTextField: UITextField!
    
    
    var messages: [ChatMessage] = [ChatMessage(fromUserID: "", text: "", timeStamp: 0)]
    var roomKey: String?{
        didSet{
            if let key = roomKey{
                fetchMessages()
                roomRef.observeSingleEvent(of: .value) { (snapshot) in
                    if let data = snapshot.value as? Dictionary<String,AnyObject>{
                        self.item.title = self.title
                    }
                }
            }
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ChatMessageViewCell
        let message = messages[indexPath.item]
        cell.textLabel.text = message.text
        setupChatCell(cell: cell, message:message)
        if message.text.count > 0{
            cell.containerViewWidthAnchor?.constant = measuredFrameHeightForeEachMessage(message: message.text).width + 32
        }
        return cell
    }
    
    func setupChatCell(cell: ChatMessageViewCell, message:ChatMessage){
        let gUID = Auth.auth().currentUser?.uid ?? "message.fromUserID"
        if message.fromUserID == gUID{
            cell.containerView.backgroundColor = UIColor.blue //내가 보낸 메시지 창 색깔
            cell.textLabel.textColor = UIColor.black
            cell.containerViewRightAnchor?.isActive = true
            cell.containerViewLeftAnchor?.isActive = false
        }else{
            cell.containerView.backgroundColor = UIColor.systemBackground //상대가 보낸 메시지 창 색깔(하얀색)
            cell.textLabel.textColor = UIColor.black
            cell.containerViewRightAnchor?.isActive = false
            cell.containerViewLeftAnchor?.isActive = true
        }
    }
    
    func measuredFrameHeightForeEachMessage(message: String) -> CGRect{
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    @IBAction func sendButton(_ sender: Any) {
        let ref = messageRef.childByAutoId()
        guard let fromUserID = Auth.auth().currentUser?.uid else{return}
        
        let data: Dictionary<String, AnyObject> = [
            "fromUserID": fromUserID as AnyObject,
            "text": chatTextField.text! as AnyObject,
            "timeStamp":NSNumber(value: Date().timeIntervalSince1970)
        ]
        
        ref.updateChildValues(data){(ref, error) in
            guard error == nil else{
                return
            }
            self.chatTextField.text = nil
            if let roomID = self.roomKey{
                roomRef.child("messages").updateChildValues([messageRef.childByAutoId().key:1])
            }
        }
        
    }
    
    func fetchMessages(){
        if let roomID = self.roomKey{
            let roomMessageRef = roomRef.child("messages")
            roomMessageRef.observe(.childAdded) { (snapshot) in
                let msgID = snapshot.key
                let msgRef = messageRef.child(msgID)
                messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let dict = snapshot.value as? Dictionary<String,AnyObject> else{
                        return
                        
                    }
                    let msg = ChatMessage(
                        fromUserID: dict["fromUserID"] as! String, text: dict["text"] as! String, timeStamp: dict["timeStamp"] as! NSNumber
                    )
                    
                    self.messages.insert(msg, at: self.messages.count - 1)
                    self.chatCollectionView.reloadData()
                    if self.messages.count >= 1 {
                        let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                    }
                    
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
}
