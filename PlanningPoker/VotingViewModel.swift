//
//  VotingViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 12/13/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

class VotingViewModel: IVotingViewModel
{
    internal var votes: MutableObservableArray<Card>
    public var planningPokerService: PlanningPokerService

    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
        votes = MutableObservableArray<Card>([])
    }
}
