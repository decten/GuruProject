//
//  ViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/12.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import BLTNBoard
//로그인 안 했을 때랑 했을 때 동작 다르게 해야 함
class MyPageViewController: UIViewController {
    
    private lazy var boardManager: BLTNItemManager = {
        let item = BLTNPageItem(title: "로그인이 필요합니다")
        item.image = UIImage(named: "lock")
        item.actionButtonTitle = "로그인 하러 가기"
        item.descriptionText = "로그인이 필요한 기능입니다"
        
        item.actionHandler = { _ in
            self.dismiss(animated: true, completion: nil)
            self.pushView(controller: "LoginViewController")
        }
        
        item.appearance.actionButtonColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.85)
        
        return BLTNItemManager(rootItem: item)
        
    }()
    
    @IBAction func goWrite(_ sender: Any) {
        boardManager.showBulletin(above: self)
    }
    
    @IBAction func goMypage(_ sender: Any) {
         boardManager.showBulletin(above: self)
    }
    
    @IBAction func goChat(_ sender: Any) {
            boardManager.showBulletin(above: self)
       }
    
    
//얘는 그냥 로그인
    @IBAction func goLogin(_ sender: Any) {
        self.pushView(controller: "LoginViewController")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
}
