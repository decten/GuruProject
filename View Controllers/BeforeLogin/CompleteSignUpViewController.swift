//
//  HomeViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/11.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit

class CompleteSignUpViewController: UIViewController {
    @IBAction func goLogin(_ sender: Any) {
        let loginView = self.storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController
        loginView!.modalPresentationStyle = .fullScreen
        self.view.window?.rootViewController = loginView
        self.view.window?.makeKeyAndVisible()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
}
