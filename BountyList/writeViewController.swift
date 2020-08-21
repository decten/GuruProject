//
//  writeViewController.swift
//  BountyList
//
//  Created by 윤하영 on 8/21/20.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit

class writeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let WriteCell = tableView.dequeueReusableCell(withIdentifier: "WriteCell", for: indexPath)
        
        return WriteCell
    }
}

//class WriteListCell: UITableViewCell {
//    @IBOutlet weak override var imgView: UIImageView!
//
//}
