//
//  HandPartsCollectionView.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/27.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import UIKit

class HandPartsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var handPartNameArray = [HandPartsCollectionViewCellModel]() {
        didSet {
            collectionView?.reloadData()
        }
    }
    var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = cellSize
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
                
        collectionView = UICollectionView(frame: CGRect(x: 0, y: topSafeAreaHeight, width: CGFloat(cellSize.width + 10), height: SCREEN_HEIGHT), collectionViewLayout: layout)
        collectionView!.allowsMultipleSelection = false
        collectionView!.backgroundColor = .black
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        self.view.addSubview(collectionView!)
        
        collectionView!.register(HandPartsCollectionViewCell.self, forCellWithReuseIdentifier: HandPartsCollectionViewCell.identifier())
    }
    
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return handPartNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HandPartsCollectionViewCell.identifier(), for: indexPath) as! HandPartsCollectionViewCell
        cell.model = handPartNameArray[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        collectionView.layoutIfNeeded()
        let cell =
            collectionView.cellForItem(at: indexPath) as! HandPartsCollectionViewCell
        
        print(cell.model!.title)
    }
}
