//
//  moveMethodsCollectionViewHelpers.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/27.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    func createMoveMethodsCollectionViewCellModels(with array: [ActionFlag], isActive: Bool) -> [MoveMethodsCollectionViewCellModel] {
        var models: [MoveMethodsCollectionViewCellModel] = []
        var time = 0
        for i in array {
            if time != 0 {
                models.append(MoveMethodsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: isActive ? UIColor.white : UIColor.gray))
            } else {
                models.append(MoveMethodsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: isActive ? UIColor.cyan : UIColor.blue))
            }
            time += 1
        }
        return models
    }
    
    func createMoveMethodsCollectionViewCellModels(disable array: [ActionFlag]) -> [MoveMethodsCollectionViewCellModel] {
        var models: [MoveMethodsCollectionViewCellModel] = []
        var time = 0
        for i in array {
            if time != 0 {
                models.append(MoveMethodsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: UIColor.gray))
            } else {
                models.append(MoveMethodsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: UIColor.blue))
            }
            time += 1
        }
        return models
    }
}
