//
//  likeViewController.swift
//  BountyList
//
//  Created by 윤하영 on 8/21/20.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class likeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

class LikeListCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!

}
