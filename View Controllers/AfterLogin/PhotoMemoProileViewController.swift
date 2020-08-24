//
//  ViewController.swift
//  MemoWithCollectionView
//


import UIKit
import CoreData


class PhotoMemoProileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {
    
    @IBOutlet weak var addBarButtonItem:UIBarButtonItem!
    @IBAction func goAdd(_ sender: Any) {
        self.pushView(controller: "PhotoMemoAddViewController")
    }
    
    @IBAction func goEdit(_ sender: Any) {
        self.pushView(controller: "PhotoMemoContentViewController")
    }
    
    
    @IBOutlet var collectionView: UICollectionView!
    var controller : NSFetchedResultsController<Photomemo>!
    var managedObjectContext: NSManagedObjectContext!

  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
        layout.minimumInteritemSpacing = 2
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width - 150)/2, height: (self.collectionView.frame.size.height - 210)/3)
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        fetchPhotomemo()
    }

    func fetchPhotomemo()
    {
        let fetchRequest : NSFetchRequest<Photomemo> = Photomemo.fetchRequest()
        let dataSort = NSSortDescriptor(key: "createdAt", ascending: false)
        fetchRequest.sortDescriptors = [dataSort]
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        self.controller = controller
        self.controller.delegate = self
        
        do {
            try controller.performFetch()
            self.collectionView.reloadData()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
            case .insert:
                if let indexPath = newIndexPath {
                    collectionView.insertItems(at: [indexPath])
            }
            break
            case .delete:
                if let indexPath = indexPath {
                    collectionView.deleteItems(at: [indexPath])
            }
            break
            case .update:
                if let indexPath = indexPath {
                    collectionView.reloadItems(at: [indexPath])
            }
            break
        default:
            break
        }
    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! PhotoMemoCollectionViewCell
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 0.5
        cell.lblname.layer.borderWidth = 0.5
        cell.lblname.layer.borderColor = UIColor.lightGray.cgColor

        let photomemo = controller.object(at: indexPath)
        cell.lblname.text = photomemo.name
        cell.photomemo = photomemo
        if let viewPhoto = UIImage(data: photomemo.photo! as Data) {
            cell.imageView.image = viewPhoto
        }
        cell.deleteButtonBackgroundView.layer.cornerRadius = cell.deleteButtonBackgroundView.bounds.width / 2.0
        cell.deleteButtonBackgroundView.layer.masksToBounds = true
        cell.deleteButtonBackgroundView.isHidden = !cell.isEditing
        
        
        return cell
    }
    
    func pushView(controller: String){
        let vc = self.storyboard?.instantiateViewController(withIdentifier: controller)
        vc!.modalPresentationStyle = .fullScreen
        self.present(vc!, animated: true, completion: nil)
    }

    
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ContentViewController" {
        let contentViewController: PhotoMemoContentViewController = segue.destination as! PhotoMemoContentViewController
        if let cell = sender as? PhotoMemoCollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell){
            
            let photomemo = controller.object(at: indexPath)


            contentViewController.photomemo = photomemo
            }
        }
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        addBarButtonItem.isEnabled = !editing
        if let indexPaths = collectionView?.indexPathsForVisibleItems {
            for indexPath in indexPaths {
                if let cell = collectionView?.cellForItem(at: indexPath) as? PhotoMemoCollectionViewCell {
                    cell.isEditing = editing
                }
            }
        }
        
        
    }
    
}



