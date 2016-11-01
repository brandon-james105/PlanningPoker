//
//  IVoterSessionSelectorViewModel.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/29/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity
import Bond

protocol IVoterSessionSelectorViewModel
{
    var mpcManager: MPCManager { get }
    var sessionInvitations: MutableObservableArray<String> { get }
}
