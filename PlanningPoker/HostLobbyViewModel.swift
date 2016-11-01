//
//  SessionViewModel.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond
import MultipeerConnectivity

final class HostLobbyViewModel : IHostLobbyViewModel
{
    public var sessionType: String = "Session Type"
    var votingSession: Session
    let voterNames = MutableObservableArray<MCPeerID>([])
    let mpcManager: MPCManager
    
    // Write the implementation of the viewmodel here.
    init(mpcManager: MPCManager)
    {
        print("HostLobbyViewModel was initialized")
        self.mpcManager = mpcManager
        self.votingSession = Session(name: "New \(self.sessionType) Session", sessionType: self.sessionType)
    }
    
}
