//
//  User.swift
//  Planning Poker
//
//  Created by Brandon James on 9/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity

private let myName = UIDevice.current.name

class User: Hashable, Equatable, MPCSerializable
{
    public var name: String
    public var hashValue: Int { return name.hash }
    public var mpcSerialized: NSData { return name.data(using: String.Encoding.utf8)! as NSData }
    
    public init (name: String)
    {
        self.name = name;
    }
    
    public required init (mpcSerialized: NSData)
    {
        name = NSString(data: mpcSerialized as Data, encoding: String.Encoding.utf8.rawValue)! as String
    }
    
    public init (peer: MCPeerID)
    {
        name = peer.displayName
    }
    
    public static func getMe() -> User
    {
        return User(name: myName)
    }
    
}

func ==(lhs: User, rhs: User) -> Bool
{
    return lhs.name != rhs.name
}
