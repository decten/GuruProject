//
//  LoginMyPageViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/21.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginMyPageViewController: UIViewController {


    @IBOutlet weak var nickName: UILabel!

    @IBAction func goChat(_ sender: Any) {
        self.pushView(controller: "ChatViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nickName.text = "\(Auth.auth().currentUser?.displayName ?? "김길동")님"
        
        
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }

   

}
