//
//  SignUpViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/11.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore
//메시지 함수 만들어서 print 내용 다 메시지로 바꾸기!!
//비밀번호 확인 기능 구현, 주소 찾기 구현, 닫기 버튼 구현
class SignUpViewController: UIViewController {
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var addressTextField_1: UITextField!
    @IBOutlet weak var addressTextField_2: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func closeWindow(_ sender: Any) {
    }
    
    
    //맞는 데이터인지 필드를 확인하고, 유효화한다. 잘못 됐으면 오류 메시지 출력
    func validateFields(){
        
        //필드가 공백이 아닌지 확인, 공백이면 오류 메시지
        if fullNameTextField.text?.trimmingCharacters(in: .whitespaces) == "" ||
            emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" ||
            passwordTextField.text?.trimmingCharacters(in: .whitespaces) == "" ||
            passwordCheckField.text?.trimmingCharacters(in: .whitespaces) == "" ||
            phoneTextField.text?.trimmingCharacters(in: .whitespaces) == "" ||
            addressTextField_1.text?.trimmingCharacters(in: .whitespaces) == "" ||
            addressTextField_2.text?.trimmingCharacters(in: .whitespaces) == ""{
            self.alertMessage("로그인 양식을 다 채워주세요")
        }
        
        //패스워드가 유효한지 확인(예: 입력한 이메일 형식이 유효한가, 8글자 이상인가, 영어 1개와 특수 문자 1개를 포함하는가 --> 인터넷에 isPasswordValid하면 정규 표현식 나옴, 상황에 맞게 사용)
        
        //위에서 텍스트 검사를 진행했기 때문에 텍스트가 있다는 것을 알아서 강제 언래핑 한다
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if isPasswordValid(cleanedPassword) == false {
            self.alertMessage("비밀번호는 최소 8글자 이상이고, 특수 문자와 숫자가 각각 1개씩 포함해야 합니다.")
        }
        
        if passwordTextField.text != passwordCheckField.text{
            self.alertMessage("입력하신 비밀번호를 확인 해주세요")
        }
        
    }
    
    @IBAction func signUpTapped(_ sender: Any) {
        self.validateFields()
        
        guard let name = fullNameTextField.text, let email = emailTextField.text, let password = passwordTextField.text else { return }
        
        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in   guard (result?.user) != nil else { return }
            self.saveFirebase(name, email, password)
            if error == nil {
                // TODO: 로그인 성공 user 객체에서 정보 사용
                let alert = UIAlertController(title: "알림", message: "\(self.fullNameTextField.text!)님 환영합니다", preferredStyle: UIAlertController.Style.alert)
                //홈으로 다시 돌아가기
                alert.addAction(UIAlertAction(title:"확인", style:UIAlertAction.Style.default, handler:{Action in self.goWellcome()}))
                self.present(alert, animated: true, completion: nil)
                
            } else {
                self.alertMessage("회원 가입 실패")
                print(error.debugDescription)
            }
        }
    }
    
    //보조 함수들
    func alertMessage(_ err:String){
        let alert = UIAlertController(title: "오류", message: err, preferredStyle: UIAlertController.Style.alert) // 메시지 박스 큰 틀
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    func saveFirebase(_ name: String, _ email:String, _ password: String){
       let db = Database.database().reference()
        db.child("/\(name)").setValue(["id":email,"password":password])
    }
    func goWellcome(){
        //as?는 캐스팅 실패시 nil 반환
        let wellcomeViewController = storyboard?.instantiateViewController(identifier: "CompleteSignUpViewController") as? CompleteSignUpViewController
        wellcomeViewController?.modalPresentationStyle = .fullScreen
        view.window?.rootViewController = wellcomeViewController
        view.window?.makeKeyAndVisible()
    }
    func isPasswordValid(_ password : String) -> Bool {
        
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
