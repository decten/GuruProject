//
//  CollectionViewCell.swift
//  MemoWithCollectionView
//
//  Created by 한병두 on 2018. 6. 1..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import CoreData


class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var lblname: UILabel!
    @IBOutlet weak var deleteButtonBackgroundView: UIVisualEffectView!

    var photomemo : Photomemo!
    
    var isEditing: Bool = false {
        didSet {
            deleteButtonBackgroundView.isHidden = !isEditing
            
        }
    }
    
    @IBAction func btnDelete(_ sender: Any) {
        context.delete(photomemo!)
        appDelegate.saveContext()
        
    }
    
    
    
}

