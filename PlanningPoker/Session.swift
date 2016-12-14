//
//  Session.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/28/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class Session
{
    var name: String = "Session"
    var host: MCPeerID? = nil
    var features: [String] = []
    var featureVotesMap = Dictionary<String, [Card]>()
    var sessionType: String = "Business Value"
    var mpcSession: MCSession = MPCManager.sharedInstance.session
    
    init() {}
    
    init(name: String, sessionType: String, session: MCSession)
    {
        self.name = name
        self.mpcSession = session
        
        switch(sessionType)
        {
        case "Business Value":
            print("falling through switch")
        case "Complexity":
            self.sessionType = sessionType
            break
        default:
            self.sessionType = "Business Value"
        }
    }
}
