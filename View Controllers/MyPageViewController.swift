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
        item.alternativeButtonTitle = "둘러만 보기"
        item.descriptionText = "로그인이 필요한 기능입니다"
        
        item.actionHandler = { _ in
            self.pushView(controller: Constants.Storyboard.lvc)
        }
        item.alternativeHandler = { _ in
            item.onDismiss() //누르면 카드 박스 없애는 역할을 하고 싶은데 실패!!!
        }
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
        self.pushView(controller: Constants.Storyboard.avc)
    }
    

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        self.present(vc!, animated: true, completion: nil)
    }
}

