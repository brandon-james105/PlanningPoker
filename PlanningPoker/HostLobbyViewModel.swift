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
    let planningPokerService: PlanningPokerService
    
    // Write the implementation of the viewmodel here.
    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
        self.votingSession = Session(
            name: "New \(self.sessionType) Session",
            sessionType: self.sessionType,
            session: self.planningPokerService.getSession().mpcSession)
        
    }
    
}
