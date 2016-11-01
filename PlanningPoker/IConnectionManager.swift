//
//  IConnectionManager.swift
//  Planning Poker
//
//  Created by Brandon James on 9/18/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol IConnectionManager
{
    func start()
    func stop()
    func getSession() -> MCSession
    func getSessionUsers() -> [MCPeerID]
}
