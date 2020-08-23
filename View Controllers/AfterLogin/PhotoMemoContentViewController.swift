//
//  ContentViewController.swift
//  MemoWithCollectionView
//


import UIKit

class PhotoMemoContentViewController: UIViewController {

    @IBOutlet var memoImageView: UIImageView!
    @IBOutlet var memoNameLabel: UITextField!
    @IBOutlet var memoBreedLabel: UITextField!
    @IBOutlet var memoSexLabel: UITextField!
    @IBOutlet var memoWeightLabel: UITextField!
    @IBOutlet var memoBirthLabel: UITextField!
    @IBOutlet var memoContentsTextView: UITextView!

    var photomemo : Photomemo!
    var viewcontroller = PhotoViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        memoNameLabel.text = photomemo.name
        memoBreedLabel.text = photomemo.breed
        memoSexLabel.text = photomemo.sex
        memoBirthLabel.text = photomemo.birth
        memoWeightLabel.text = photomemo.weight
        memoContentsTextView.text = photomemo.contents
        let changeData = UIImage(data: photomemo.photo! as Data)
        memoImageView.image = changeData
        
        self.title = memoNameLabel.text
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Edit" {
        let editViewController: PhotomMemoEditViewController = segue.destination as! PhotomMemoEditViewController
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
