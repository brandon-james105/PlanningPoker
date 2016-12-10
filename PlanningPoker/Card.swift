//
//  Card.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/9/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

public class Card: MPCSerializable
{
    var face: String = ""
    var effortValue: Double?
    
    public var mpcSerialized: NSData { return face.data(using: String.Encoding.utf8)! as NSData }
    
    public required init (mpcSerialized: NSData)
    {
        self.face = NSString(data: mpcSerialized as Data, encoding: String.Encoding.utf8.rawValue)! as String
        effortValue = Double.init(self.face)
    }
    
    init (faceValue: String = "")
    {
        face = faceValue
        effortValue = Double.init(faceValue)
    }
}
