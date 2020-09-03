//
//  handPartsCollectionViewHelpers.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/27.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import UIKit

extension MainViewController {
    func createHandPartCellModelModels(with array: [HandPartFlag], isActive: Bool) -> [HandPartsCollectionViewCellModel] {
        var models: [HandPartsCollectionViewCellModel] = []
        var time = 0
        for i in array {
            if time != 0 {
                models.append(HandPartsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: isActive ? UIColor.white : UIColor.gray))
            } else {
                models.append(HandPartsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: isActive ? UIColor.cyan : UIColor.blue ))
            }
            time += 1
        }
        return models
    }
    
    
    func createHandPartCellModelModels(disable array: [HandPartFlag]) -> [HandPartsCollectionViewCellModel] {
        var models: [HandPartsCollectionViewCellModel] = []
        var time = 0
        for i in array {
            if time != 0 {
                models.append(HandPartsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: UIColor.gray))
            } else {
                models.append(HandPartsCollectionViewCellModel(title: "\(i)", cellFlag: i, color: UIColor.blue))
            }
            time += 1
        }
        return models
    }
}
