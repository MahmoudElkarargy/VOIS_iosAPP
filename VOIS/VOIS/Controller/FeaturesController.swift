//
//  FeaturesController.swift
//  VOIS
//
//  Created by Mahmoud Elkarargy on 3/25/21.
//
import UIKit

class FeaturesController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    @IBOutlet weak var collectionView: UICollectionView!
    
    let featuresLabel = ["Money Count", "Object Detection", "bla bla", "bla bla", "bla bla"]
    let featuresImages: [UIImage] = [
        UIImage(named: "AppLogo")!,
        UIImage(named: "AppLogo")!,
        UIImage(named: "AppLogo")!,
        UIImage(named: "AppLogo")!,
        UIImage(named: "AppLogo")!,
    ]
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return featuresLabel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        cell.label.text = featuresLabel[indexPath.item]
        cell.image.image = featuresImages[indexPath.item]
        
        return cell
    }
    
    
    override func viewDidLoad() {
        collectionView.dataSource = self
        collectionView.delegate = self
        
        //set spacing of cells.
        let layout = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 10)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.collectionView.frame.size.width-20)/2, height: (self.collectionView.frame.size.height)/3)
    }
    
}
