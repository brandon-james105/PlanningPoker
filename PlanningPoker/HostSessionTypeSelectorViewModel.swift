//
//  SessionSelectorViewModel.swift
//  Planning Poker
//
//  Created by Brandon James on 9/13/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation

final class HostSessionTypeSelectorViewModel: IHostSessionTypeSelectorViewModel
{
    var planningPokerService: PlanningPokerService
    
    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
    }
}
