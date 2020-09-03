//
//  MoveMethodsCollectionViewCell.swift
//  ARHandSimulatorFever
//
//  Created by Kagamigawa on 2020/04/28.
//  Copyright © 2020 JohnBo. All rights reserved.
//

import Foundation
import UIKit

struct MoveMethodsCollectionViewCellModel {
    let title: String
    let cellFlag: ActionFlag
    let color: UIColor
}

class MoveMethodsCollectionViewCell: UICollectionViewCell {
    class func identifier() -> String {
        return NSStringFromClass(MoveMethodsCollectionViewCell.self)
    }
    
    var model: MoveMethodsCollectionViewCellModel? {
        didSet {
            textLabel.text = model!.title
            textLabel.sizeToFit()
            self.contentView.backgroundColor = model!.color
        }
    }
    private var textLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 17)
        textLabel.textColor = .black
        textLabel.textAlignment = .center
        textLabel.adjustsFontSizeToFitWidth = true
        textLabel.lineBreakMode = .byWordWrapping
        self.addSubview(textLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        textLabel.frame = CGRect(x: 0, y: 0,width: self.frame.size.width , height: self.frame.size.height)
        textLabel.frame.origin.x = (self.frame.size.width - textLabel.frame.size.width) / 2
        textLabel.frame.origin.y = (self.frame.size.height - textLabel.frame.size.height) / 2
        textLabel.adjustsFontSizeToFitWidth = true
    }
}
