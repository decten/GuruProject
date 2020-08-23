
//
//  AddViewController.swift
//  MemoWithCollectionView
//
//  Created by 한병두 on 2018. 6. 8..
//  Copyright © 2018년 Byungdoo Han. All rights reserved.
//

import UIKit

class AddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var btnImage: UIButton!
    @IBOutlet var text_contents: UITextView!
    @IBOutlet var text_name: UITextField!
    @IBOutlet var text_birth: UITextField!
    @IBOutlet var text_sex: UITextField!
    @IBOutlet var text_breed: UITextField!
    @IBOutlet var text_weight: UITextField!
    //    var mainViewController = ViewController()

    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        text_contents!.layer.borderWidth = 0.5
        text_contents!.layer.borderColor = UIColor.lightGray
            .cgColor
        text_contents!.layer.cornerRadius = 5.0

        // Do any additional setup after loading the view.
    }
   

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func btnImageEdit(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        _ = imagePickerController.allowsEditing = false
        self.present(imagePickerController, animated: true, completion: nil)
    }
    @IBAction func btnImageDelete(_ sender: Any) {
        imageView.image = nil
        btnImage.isHidden = false
    }
    
    @IBAction func btnDone(_ sender: Any) {
        let name = text_name.text
        let contents = text_contents.text
        let birth = text_birth.text
        let sex = text_sex.text
        let breed = text_breed.text
        let weight = text_weight.text
        let selectedImage = imageView.image
        let transferData : Data = selectedImage!.pngData()!

        let photomemo = Photomemo(context: context)
       
        photomemo.photo = transferData as NSData
        photomemo.name = name
        photomemo.breed = breed
        photomemo.sex = sex
        photomemo.birth = birth
        photomemo.weight = weight
        photomemo.contents = contents
        photomemo.createdAt = NSDate()
        appDelegate.saveContext()
        _ = navigationController?.popViewController(animated: true)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage {
            imageView.image = image
            self.image = image
            self.dismiss(animated: true, completion: nil)
            btnImage.isHidden = true
        }
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
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    
}


