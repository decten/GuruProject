//
//  UserModel.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/19.
//  Copyright © 2020 김현아. All rights reserved.
//
import UIKit
//import Foundation

//말풍선,프로필 사진 뺐습니다
struct ChatMessage {
    var fromUserID: String //누구한테 왔는가
    var text: String //내용
    var timeStamp: NSNumber //언제 보냈는가
}

//채팅방
struct Room{
    var key: String
    var name: String
    var image: UIImage
    var messages: Dictionary<String, Int>
    
    init(key:String, name:String) { //채팅방들의 기본 정보
        self.key = key
        self.image = UIImage(systemName: "person.fill")!
        self.name = name
        self.messages = [:] //딕셔너리 타입을 명시적으로 미리 선언해서 간단하게 초기화 가능
    }
    
    init(key:String, data: Dictionary<String, AnyObject>){ //각 채팅방이 가지는 말풍선 참조
        self.key = key
        self.image = UIImage(systemName: "person.fill")!
        self.name = data["name"] as! String
        if let messages = data["messages"] as? Dictionary<String,Int>{
            self.messages = messages
        }else{
            self.messages = [:]
        }
    }
}

struct User{
    var password: String
    var email: String
    var userName: String
    var room: Dictionary<String,String>
    
    init(password: String, email: String, userName: String) {
        self.password = password
        self.email = email
        self.userName = userName
        self.room = [:]
    }
}
