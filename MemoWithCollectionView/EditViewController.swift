//
//  EditViewController.swift
//  MemoWithCollectionView
//
//  Created by 한병두 on 2018. 7. 3..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit
import CoreData

class EditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var edit_imageView: UIImageView!
    @IBOutlet weak var edit_name: UITextField!
    @IBOutlet weak var edit_breed: UITextField!
    @IBOutlet weak var edit_sex: UITextField!
    @IBOutlet weak var edit_birth: UITextField!
    @IBOutlet weak var edit_weight: UITextField!
    @IBOutlet weak var edit_content: UITextView!
    
    @IBOutlet weak var edit_btnImage: UIButton!
    
    var photomemo : Photomemo?
    
    var editImage:UIImage?
    var editName:String!
    var editBreed:String!
    var editSex:String!
    var editBirth:String!
    var editWeight:String!
    var editContent:String!
    var tempImage:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        edit_imageView.image = editImage
        edit_name.text = editName
        edit_sex.text = editSex
        edit_breed.text = editBreed
        edit_birth.text = editBirth
        edit_weight.text = editWeight
        edit_content.text = editContent
        edit_content!.layer.borderWidth = 0.5
        edit_content!.layer.borderColor = UIColor.lightGray
            .cgColor
        edit_content!.layer.cornerRadius = 5.0
        edit_btnImage.isHidden = true
    }
    
    @IBAction func edt_AddImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func edit_ChangeImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func edit_DeleteImage(_ sender: Any) {
        edit_imageView.image = nil
        edit_btnImage.isHidden = false

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            edit_imageView.image = image
            self.tempImage = image
            self.dismiss(animated: true, completion: nil)
            edit_btnImage.isHidden = true
        }
    }
    
    @IBAction func edit_Done(_ sender: Any) {
        let name = edit_name.text
        let breed = edit_breed.text
        let sex = edit_sex.text
        let birth = edit_birth.text
        let weight = edit_weight.text
        let contents = edit_content.text
        let selectedImage = edit_imageView.image
        let transferData : Data = selectedImage!.pngData()!
        
//        let photomemo = Photomemo(context: context)

        photomemo!.name = name
        photomemo!.breed = breed
        photomemo!.sex = sex
        photomemo!.birth = birth
        photomemo!.weight = weight
        photomemo!.contents = contents
        photomemo!.createdAt = NSDate()
        photomemo!.photo = transferData as NSData

        appDelegate.saveContext()
        
        let  vc =  self.navigationController?.viewControllers.filter({$0 is ViewController}).first
        self.navigationController?.popToViewController(vc!, animated: true)
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
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
