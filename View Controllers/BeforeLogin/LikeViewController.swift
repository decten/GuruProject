//
//  likeViewController.swift
//  BountyList
//
//  Created by 윤하영 on 8/21/20.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import BLTNBoard

class LikeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    private lazy var boardManager: BLTNItemManager = {
          let item = BLTNPageItem(title: "로그인이 필요합니다")
          item.image = UIImage(named: "lock")
          item.actionButtonTitle = "로그인 하러 가기"
          item.descriptionText = "로그인이 필요한 기능입니다"
          
          item.actionHandler = { _ in
              self.pushView(controller: "LoginViewController")
          }
          
          item.appearance.actionButtonColor = UIColor(red: 51/255, green: 153/255, blue: 255/255, alpha: 0.85)
          
          return BLTNItemManager(rootItem: item)
          
      }()
    
    @IBAction func goHome(_ sender: Any) {
        self.pushView(controller: "MyPageViewController")
    }
    
    @IBAction func goWrite(_ sender: Any) {
    boardManager.showBulletin(above: self)
    }
    
    @IBAction func goChat(_ sender: Any) {
    boardManager.showBulletin(above: self)
    }
    
    @IBAction func goMyPage(_ sender: Any) {
    self.pushView(controller: "HomeViewController")
    }
    
    let roomList = ["room2", "room3"]
    let addressList = ["성동구 성수1가2동 쌍용 아파트", "성북구 양재동 현대 아파트"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return roomList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell",for: indexPath) as? LikeListCell else{
            return UITableViewCell()
        }
                
        let img = UIImage(named: "\(roomList[indexPath.row]).jpg")
        cell.imgView.image = img
        cell.addressLabel.text = roomList[indexPath.row]
        cell.tagLabel.text = "\(addressList[indexPath.row])"
        
        return cell
        
        
        
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

 class LikeListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!

}
