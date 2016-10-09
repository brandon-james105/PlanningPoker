//
//  MPCSerializable.swift
//  Planning Poker
//
//  Created by Brandon James on 9/27/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation

public protocol MPCSerializable
{
    var mpcSerialized: NSData { get }
    init(mpcSerialized: NSData)
}