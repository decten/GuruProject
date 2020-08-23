//
//  LoginViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/11.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import KakaoSDKAuth
import KakaoSDKUser
import FirebaseAuth
import FirebaseDatabase

//sns 로그인 성공하면 성공 페이지로 넘어가도록 수정!!, 회원가입 할 때는 pushview를 그냥 이동으로 바꿔야 함 
class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBAction func closeTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func loginTapped(_ sender: Any) {

        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if error != nil {
                self.alertMessage()
                
            }
            else{//성공 하면 홈이 없으니까 일단 로그인 마이페이지로
                self.pushView(controller: "LoginMyPageViewController")
            }
        }
    }
    //구글 로그인 버튼
    @IBAction func googleLogin(_ sender: Any) {
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
        
        let user = Auth.auth().currentUser
        if  user != nil {
            let name = user?.displayName ?? "none"
            let password = (user?.uid)!
            let email = (user?.email)!
            self.saveFirebase(name, email, password)
            
            Auth.auth().addStateDidChangeListener { (user, error) in
                self.pushView(controller: "LoginMyPageViewController")
            }
        }
        
    }
    
    @IBAction func kakaoLogin(_ sender: Any) {
        
          // 웹로그인 방식만 사용할 경우 false, 카카오톡앱 방식도 병행할 경우 true
              let useKakaoTalkLogin = false;
              
              let kakaoTalkInstalled = AuthApi.isKakaoTalkLoginAvailable()
              if ( !kakaoTalkInstalled )
              {
                  print("카카오톡이 없습니다")
              }
              
              //카카오 설치 확인
              if (useKakaoTalkLogin && kakaoTalkInstalled) {
                  AuthApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                      if let error = error {
                          // 카카오 앱 인증 오류 발생
                          print(error)
                      }
                      else {
                          print("loginWithKakaoTalk() success.")
                          
                          guard let ot = oauthToken else {
                              print("oauthToken is not available!")
                              return
                          }
                          DispatchQueue.main.async {
                              self.firebaseAppLoginWithKakao(ot)
                          }
                      }
                  }
              }
              else
              {
                  print("웹뷰에서 카카오계정 정보를 입력하여 로그인 시도하기")
                  
                  AuthApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                      if let error = error {
                          // 카카오 계정 인증 오류 발생
                          print(error)
                      }
                      else {
                          print("loginWithKakaoAccount() success.")
                          
                          guard let ot = oauthToken else {
                              print("oauthToken is not available!")
                              return
                          }
                          DispatchQueue.main.async {
                              self.firebaseAppLoginWithKakao(ot)
                          }
                      }
                  }
              }
          }
          
          // 사용자 정보 가져오기는 아래 URL 참고 (사용자가 정보 제공 동의하지 않았거나 해당 정보를 카카오에 제공하지 않은경우 사용자 정보는 nil의 값 가짐)
          // https://developers.kakao.com/docs/latest/ko/user-mgmt/ios
          
          func loginFirebase(_ name: String, _ email: String, _ password: String) {
              Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                  if error != nil {
                      
                      Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                          if ( error != nil ) {
                              self.alertMessage()
                          }
                          else {
                               self.saveFirebase(name, email, String(password))
                            self.pushView(controller:"LoginMyPageViewController")
                          }
                      }
                  }
                  else{//성공 하면 다시 이전 화면으로 바꾸고, 환영 문구 메시지로
                      self.pushView(controller:"LoginMyPageViewController")
                  }
              }
          }
          
          func firebaseAppLoginWithKakao(_ oauthTokken: OAuthToken) {
              // 로그인 정보 받아오기
              UserApi.shared.me() {(user, error) in
                  if let error = error {
                      print(error)
                  }
                  else {
                      if let user = user {
                          
                          // https://developers.kakao.com/docs/latest/ko/user-mgmt/ios
                          var scopes = [String]()
                          
                          if (user.kakaoAccount?.emailNeedsAgreement == true) { scopes.append("account_email") }
                          if (user.kakaoAccount?.birthdayNeedsAgreement == true) { scopes.append("birthday") }
                          if (user.kakaoAccount?.profileNeedsAgreement == true) { scopes.append("profile") }
                          if (user.kakaoAccount?.ageRangeNeedsAgreement == true) { scopes.append("age_range") }
                          
                          if scopes.count == 0  {
                              // 여기에서 user.kakaoAccount.email 과 user.id 값으로 FirebaseApp 에 이미일/비밀번호 방식으로 인증
                              // email: user.kakaoAccount.email
                              // password: user.id
                              
                              let name = user.kakaoAccount?.profile?.nickname ?? "none"
                              let password = user.id
                              let email = user.kakaoAccount?.email ?? "none"
                              self.loginFirebase(name, email, String(password))
                              return
                          }
                          
                          // 필요한 scope으로 토큰갱신
                          AuthApi.shared.loginWithKakaoAccount(scopes: scopes) { (oauthToken, error) in
                              if let error = error {
                                  print(error)
                              }
                              else {
                                  UserApi.shared.me() { (user, error) in
                                      if let error = error {
                                          // 카카오 계정 인증 오류 발생
                                          print(error)
                                      }
                                      else {
                                          print("loginWithKakaoAccount() success.")
                                          
                                          guard let user = user else {
                                              print("user is nil.")
                                              return
                                          }
                                          let name = user.kakaoAccount?.profile?.nickname ?? "none"
                                          let password = user.id //고유 아이디를 비밀번호로 저장
                                          let email = user.kakaoAccount?.email ?? "none"
                                          self.loginFirebase(name, email, String(password))
                                      }
                                      
                                  }
                              }
                              
                          }
                      }
                  }
              }
          }
    
    //메인 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //현재 접속 중인 유저 uid 가져오기
        var currentUserUid: String?{
            get{
                guard let uid = Auth.auth().currentUser?.uid else{
                    return nil
                }
                return uid
            }
        }
    }
    
    func saveFirebase(_ name: String, _ email:String, _ password: String){
        let db = Database.database().reference()
       db.child("/\(name)").setValue(["id":email,"password":password]) //유저밑에 만들고 싶어서 이렇게 했는데 잘 되려나

    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: false, completion: nil)
    }
    
    func alertMessage(){
        let alert = UIAlertController(title: "오류", message: "로그인에 실패 했습니다", preferredStyle: UIAlertController.Style.alert) // 메시지 박스 큰 틀
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

