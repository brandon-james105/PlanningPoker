//
//  SessionViewModel.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

final class VotingSessionViewModel : IVotingSessionViewModel
{
    public var sessionType: String = "Session Type"
    public var voterNames: ObservableArray<User>
    let session: IConnectionManager
    
    // Write the implementation of the viewmodel here.
    init(session: IConnectionManager)
    {
        print("VotingSessionViewModel was initialized")
        voterNames = ObservableArray([])
        self.session = session
    }
    
    public func startSession()
    {
        session.start()
    }
    
}
