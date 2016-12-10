//
//  VoterSessionSelectorViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/29/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

final class VoterSessionSelectorViewModel : IVoterSessionSelectorViewModel
{
    let planningPokerService: PlanningPokerService
    var sessionInvitations = MutableObservableArray<MCPeerID>([])
    
    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
    }
}
