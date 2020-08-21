//
//  DetailViewController.swift
//  BountyList
//
//  Created by Hayoung Yoon on 2020/08/05.
//  Copyright © 2020 Hayoung Yoon. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bountyLabel: UILabel!

    var name: String?
    var bounty: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }
    
    func updateUI() {
        if let name = self.name, let bounty = self.bounty{
            let img = UIImage(named: "\(name).jpg")
            imgView.image = img
            nameLabel.text = name
            bountyLabel.text = "\(bounty)"
        }
    }
    
    
    //x버튼 누르면 모달 화면 닫힘 구현
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
