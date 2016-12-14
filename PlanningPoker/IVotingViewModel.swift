//
//  IVotingViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 12/13/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

protocol IVotingViewModel
{
    var votes: MutableObservableArray<Card> { get set }
    var planningPokerService: PlanningPokerService { get set }
}
