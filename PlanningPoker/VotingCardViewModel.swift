//
//  VotingCardViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 12/10/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

final class VotingCardViewModel
{
    var planningPokerService: PlanningPokerService
    let cards: ObservableArray<Card>
    let session: Session
    
    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
        self.session = planningPokerService.getSession()
        
        cards = ObservableArray<Card>(CardManager.setUpCards(forType: session.sessionType))
    }
}
