//
//  CollectionViewCell.swift
//  MemoWithCollectionView
//


import UIKit
import CoreData


class PhotoCollectionViewCell: UICollectionViewCell {
    
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

