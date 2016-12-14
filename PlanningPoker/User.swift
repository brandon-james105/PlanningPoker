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

class User: Hashable, Equatable
{
    var name: String = UIDevice.current.name
    var myPeer: MCPeerID
    public var hashValue: Int { return name.hash }
    
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
