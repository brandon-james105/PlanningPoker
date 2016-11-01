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
    var face: String = ""
    var effortValue: Int?
    
    init (faceValue: String = "")
    {
        face = faceValue
        effortValue = Int.init(faceValue)
    }
}
