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
}
