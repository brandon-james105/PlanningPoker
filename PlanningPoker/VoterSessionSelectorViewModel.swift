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

class VoterSessionSelectorViewModel : IVoterSessionSelectorViewModel
{
    let mpcManager: MPCManager
    var sessionInvitations = MutableObservableArray<String>([])
    
    // Write the implementation of the viewmodel here.
    init(mpcManager: MPCManager)
    {
        print("VoterSessionSelectorViewModel was initialized")
        self.mpcManager = mpcManager
    }
}
