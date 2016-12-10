//
//  PlanningPokerService.swift
//  PlanningPoker
//
//  Created by Brandon James on 11/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation

class PlanningPokerService
{
    static let sharedInstance = PlanningPokerService()
    var mpcManager = MPCManager.sharedInstance
    private var session: Session = Session()
    
    func setSession(session: Session)
    {
        self.session = session
    }
    
    func getSession() -> Session
    {
        return self.session
    }
    
    func sendSessionInit()
    {
        let mpc = self.mpcManager
        let messageDictionary: [String: String] = ["message": "_start_session_"]
        
        if (mpc.sendData(dictionaryWithData: messageDictionary, toPeers: mpc.foundPeers))
        {
            print("sent session init to peers")
        }
        else
        {
            print("Could not send session init")
        }
    }
    
    func sendCard(card: Card)
    {
        let mpc = self.mpcManager
        let messageDictionary: [String: String] = ["cardValue": String(card.face)]
        
        if (mpc.sendData(dictionaryWithData: messageDictionary, toPeers: mpc.foundPeers))
        {
            print("sent card (\(card.face)) to peers")
        }
        else
        {
            print("Could not send session init")
        }
    }
}
