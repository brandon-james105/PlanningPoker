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
    
    func sendSessionInit(sessionType: String)
    {
        let mpc = self.mpcManager
        let messageDictionary: [String: String] = ["_start_session_": sessionType]
        
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
        let messageDictionary: [String: String] = ["card": card.face]
        
        if (mpc.sendData(dictionaryWithData: messageDictionary, toPeers: [self.session.host!]))
        {
            print("sent card (\(card.face)) to host")
        }
        else
        {
            print("Could not send card face")
        }
    }
    
    func sendFeature(feature: String)
    {
        let mpc = self.mpcManager
        let messageDictionary: [String: String] = ["card": String(feature)]
        
        if (mpc.sendData(dictionaryWithData: messageDictionary, toPeers: mpc.foundPeers))
        {
            print("sent card (\(feature)) to peers")
        }
        else
        {
            print("Could not send feature")
        }
    }
}
