//
//  AlertViewController.swift
//  LoginProject
//
//  Created by 김현아 on 2020/08/12.
//  Copyright © 2020 김현아. All rights reserved.
//

import UIKit
import SPPermissions
//완성은 했는데 회원가입 창의 모달로 빼기
class AlertViewController: UIViewController{
//, SPPermissionsDelegate, SPPermissionsDataSource {
//    func configure(_ cell: SPPermissionTableViewCell, for permission: SPPermission) -> SPPermissionTableViewCell {
//        <#code#>
//    } 주석은 추가적으로 UI나 데이터 셀 변경하는 부분
    
    @IBOutlet var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButtion(){
        let controller = SPPermissions.list([.camera, .locationWhenInUse])
        
        controller.titleText = "허용 목록"
        controller.headerText = "앱 사용을 위해 허용해주세요"
        controller.footerText = "반드시 필요합니다!"
        
//        controller.delegate = self
//        controller.dataSource = self
        
        controller.present(on: self)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
