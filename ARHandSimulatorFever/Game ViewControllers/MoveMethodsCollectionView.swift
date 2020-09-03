//
//  MoveMethodsCollectionView.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/27.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import UIKit

class MoveMethodsCollectionView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var moveMethodNameArray: [MoveMethodsCollectionViewCellModel] = [] {
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
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 2, left: 1, bottom: 2, right: 5)
        
        collectionView = UICollectionView(frame: CGRect(x: cellSize.width + 10, y: topSafeAreaHeight, width: SCREEN_WIDTH - cellSize.width - 10, height: cellSize.height + 10), collectionViewLayout: layout)
        collectionView!.allowsMultipleSelection = false
        collectionView!.backgroundColor = .black
        collectionView!.delegate = self
        collectionView!.dataSource = self
        
        self.view.addSubview(collectionView!)
        
        collectionView!.register(MoveMethodsCollectionViewCell.self, forCellWithReuseIdentifier: MoveMethodsCollectionViewCell.identifier())
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moveMethodNameArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoveMethodsCollectionViewCell.identifier(), for: indexPath) as! MoveMethodsCollectionViewCell
        
        cell.model = moveMethodNameArray[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let cell = collectionView.cellForItem(at: indexPath) as! MoveMethodsCollectionViewCell
        
        print(cell.model!.title)
    }
}
