//
//  ISessionViewModel.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

protocol IHostLobbyViewModel
{
    // Write the implementation of the viewmodel here.
    var sessionType: String { get set }
    var votingSession: Session { get set }
    var voterNames: MutableObservableArray<MCPeerID> { get }
    var mpcManager: MPCManager { get }
}
