//
//  BountyViewController.swift
//  BountyList
//
//  Created by Hayoung Yoon on 2020/08/05.
//  Copyright © 2020 Hayoung Yoon. All rights reserved.
//

import UIKit
import BLTNBoard

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
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
    
    let nameList = ["room1", "room2", "room3", "room4", "room5", "room6", "room7"]
    let dayList = [33000, 50000, 44000, 36000, 80000, 27000, 40000]
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // DetailViewController 데이터 주는 역할
        if segue.identifier == "showDetail" {
            let vc = segue.destination as? DetailViewController
            if let index = sender as? Int {
                vc?.name = nameList[index]
                vc?.bounty = dayList[index]
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // UITableViewDataSource, 처음에 몇갠지 물어보는거(리턴할 개수 정하기)
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dayList.count
    }
    
    //테이블뷰 재활용하기
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else {
            return UITableViewCell()
        }
        
        let img = UIImage(named: "\(nameList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.nameLabel.text = nameList[indexPath.row]
        cell.bountyLabel.text = "\(dayList[indexPath.row])"
        return cell
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }
    
    @IBAction func goLikeList(_ sender: Any) {
        boardManager.showBulletin(above: self)
    }
    
    @IBAction func goWrite(_ sender: Any) {
        boardManager.showBulletin(above: self)
    }
    
    @IBAction func goChat(_ sender: Any) {
        boardManager.showBulletin(above: self)
    }
    
    // UITableViewDelegate (showDetail은 홈화면과 상세페이지 모달연결한 화살표의 identifier 이름이다.)
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: indexPath.row)
        
    }
}

//커스텀셀(내맘대로디자인)하기
class ListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!
}
