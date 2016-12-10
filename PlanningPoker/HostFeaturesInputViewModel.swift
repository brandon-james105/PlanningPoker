//
//  HostFeaturesInputViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 11/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

final class HostFeaturesInputViewModel : IHostFeaturesInputViewModel
{
    var planningPokerService: PlanningPokerService
    
    init(planningPokerService: PlanningPokerService)
    {
        self.planningPokerService = planningPokerService
    }
}
