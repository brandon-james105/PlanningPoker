//
//  Card.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/9/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

public class Card
{
    var face: String
    var effortValue: Double?
    
    public required init (mpcSerialized: NSData)
    {
        let dict = NSKeyedUnarchiver.unarchiveObject(with: mpcSerialized as Data) as! [String: String]
        face = dict["face"]!
        effortValue = Double.init(dict["efforValue"]!)
    }
    
    init (faceValue: String = "0")
    {
        face = faceValue
        effortValue = Double.init(faceValue)
        if (effortValue == nil)
        {
            effortValue = 0
        }
        if (faceValue == "½")
        {
            effortValue = 0.5
        }
    }
}
