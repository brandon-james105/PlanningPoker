//
//  CardCell.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/17/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import UIKit

class CardCell: UICollectionViewCell
{
    var textLabel: UILabel!
    
    override init(frame: CGRect)
    {
        textLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: frame.size.height))
        super.init(frame: frame)
        
        textLabel = UILabel(frame: CGRect(x: 0, y: frame.size.height, width: frame.size.width, height: frame.size.height/3))
        textLabel.font = UIFont.systemFont(ofSize: UIFont.smallSystemFontSize)
        textLabel.textAlignment = .center
        contentView.addSubview(textLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
