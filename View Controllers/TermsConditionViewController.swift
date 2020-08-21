//
//  TermsConditionViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/11.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit

class TermsConditionViewController: UIViewController{
    //버튼 클릭시 모양 변경-false는 기본 true는 체크 상태
    //함수로 한 번에 처리할 수는 없는가
    //취소 버튼 바꾸기!!!
    
    @IBOutlet weak var checkBox1: UIButton!
    @IBOutlet weak var checkBox2: UIButton!
    @IBOutlet weak var checkBox3: UIButton!
    
    var flag1 = false ,flag2 = false ,flag3 = false
    
    @IBAction func checkButton1(_ sender: UIButton) {
        
        if flag1 == false {
            checkBox1.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            checkBox2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            checkBox3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            flag1 = true
        }else{
            checkBox1.setImage(UIImage(systemName: "square"), for: .normal)
            flag1 = false
        }
        
    }
    @IBAction func checkButton2(_ sender: UIButton) {
        
        if flag2 == false{
            checkBox2.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            flag2 = true
        }else{
            checkBox2.setImage(UIImage(systemName: "square"), for: .normal)
            flag2 = false
        }
    }
    
    @IBAction func checkButton3(_ sender: UIButton) {
        
        if flag3 == false{
            checkBox3.setImage(UIImage(systemName: "checkmark.square"), for: .normal)
            flag3 = true
        }else{
            checkBox3.setImage(UIImage(systemName: "square"), for: .normal)
            flag3 = false
        }
    }
    
    //SignUpViewController로 연결, 약관 동의 안 하면 못 넘어감, 여기를 좀 더 아름답게 짤 수는 없나!!!!!
    @IBAction func nextStep(_ sender: Any) {
       
            if flag1 == false{
                if flag2 == false || flag3 == false{
                    //실패, 메시지 출력
                    let alert = UIAlertController(title: "알림", message: "약관에 모두 동의해주세요", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default, handler:nil))
                    present(alert, animated: false, completion: nil)

                }else{
                    //성공(작은 박스 2개 클릭)
                    self.goSignUp()
                }
            }else{
                //성공(약관 모두 동의)
                self.goSignUp()
            }
        
    }
    
    @IBAction func deleteStep(_ sender: Any) {
        self.goSignUp()//여기 바꿔야 함!!!
    }
    
    func goSignUp(){
        let signupViewController = self.storyboard?.instantiateViewController(identifier: Constants.Storyboard.svc) as? SignUpViewController
        
            self.view.window?.rootViewController = signupViewController
            self.view.window?.makeKeyAndVisible()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dismiss(animated: true, completion: nil)
    }
    
}
