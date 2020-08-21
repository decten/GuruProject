//
//  ContentViewController.swift
//  MemoWithCollectionView
//
//  Created by 한병두 on 2018. 6. 16..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit

class ContentViewController: UIViewController {

    @IBOutlet var memoImageView: UIImageView!
    @IBOutlet var memoNameLabel: UITextField!
    @IBOutlet var memoBreedLabel: UITextField!
    @IBOutlet var memoSexLabel: UITextField!
    @IBOutlet var memoWeightLabel: UITextField!
    @IBOutlet var memoBirthLabel: UITextField!
    @IBOutlet var memoContentsTextView: UITextView!

    var photomemo : Photomemo!
    var viewcontroller = ViewController()

//    var titleBox = ""
//    var contentBox = ""
//    var imageBox : UIImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        memoTitleLabel.text = titleBox
//        memoContentsTextView.text = contentBox
//        memoImageView.image = imageBox
        
        memoNameLabel.text = photomemo.name
        memoBreedLabel.text = photomemo.breed
        memoSexLabel.text = photomemo.sex
        memoBirthLabel.text = photomemo.birth
        memoWeightLabel.text = photomemo.weight
        memoContentsTextView.text = photomemo.contents
        let changeData = UIImage(data: photomemo.photo! as Data)
        memoImageView.image = changeData
        
        self.title = memoNameLabel.text
        
  
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit" {
        let editViewController: EditViewController = segue.destination as! EditViewController
            editViewController.editImage = memoImageView.image
            editViewController.editName = memoNameLabel.text
            editViewController.editBreed = memoBreedLabel.text
            editViewController.editSex = memoSexLabel.text
            editViewController.editBirth = memoBirthLabel.text
            editViewController.editWeight = memoWeightLabel.text
            editViewController.editContent = memoContentsTextView.text

            photomemo.name = memoNameLabel.text
            photomemo.breed = memoBreedLabel.text
            photomemo.sex = memoSexLabel.text
            photomemo.birth = memoBirthLabel.text
            photomemo.weight = memoWeightLabel.text
            photomemo.contents = memoContentsTextView.text
            let selectedImage = memoImageView.image
            let transferData : Data = selectedImage!.pngData()!
            photomemo.photo = transferData as NSData
            
            editViewController.photomemo = photomemo!

        }

    }
    


 }
