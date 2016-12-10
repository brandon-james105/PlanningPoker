//
//  User.swift
//  Planning Poker
//
//  Created by Brandon James on 9/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

private let myName = UIDevice.current.name

class User: Hashable, Equatable, MPCSerializable
{
    var name: String = UIDevice.current.name
    var myPeer: MCPeerID
    public var hashValue: Int { return name.hash }
    public var mpcSerialized: NSData { return name.data(using: String.Encoding.utf8)! as NSData }
    
    public init()
    {
        self.myPeer = MCPeerID(displayName: self.name)
    }
    
    public init (name: String)
    {
        self.name = name
        self.myPeer = MCPeerID(displayName: name)
    }
    
    public init (peer: MCPeerID)
    {
        self.name = peer.displayName
        self.myPeer = peer
    }
    
    public required init (mpcSerialized: NSData)
    {
        name = NSString(data: mpcSerialized as Data, encoding: String.Encoding.utf8.rawValue)! as String
        myPeer = MCPeerID(displayName: name)
    }
    
    public static func getMe() -> User
    {
        return User(name: myName)
    }
    
    public func setName(name: String)
    {
        self.name = name
        self.myPeer = MCPeerID(displayName: name)
    }
    
}

func ==(lhs: User, rhs: User) -> Bool
{
    return lhs.name != rhs.name
}
