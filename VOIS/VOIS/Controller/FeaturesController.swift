//
//  FeaturesController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//
import UIKit

class FeaturesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        let feature = FeatureOption(rawValue: indexPath.item)
        cell.image.image = feature?.image
        
        //Modify cell
        
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 10
        cell.layer.masksToBounds = true
        
        cell.layer.masksToBounds = false
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 0.2
        cell.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.layer.shadowRadius = cell.layer.cornerRadius
        return cell
    }
    
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        self.setupNavigationBar(image: UIImage(named: "WhiteLogo")!)
    }
    
}
extension UIViewController {
    func setupNavigationBar(image: UIImage) {

        //set image in the center
         self.navigationItem.titleView = UIImageView(image: image)
    }
}
