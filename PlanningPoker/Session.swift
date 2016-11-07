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
    var name: String = ""
    var cards: [Card] = []
    var features: [String] = []
    var featureVotesMap = Dictionary<Double, String>()
    var sessionType: String = ""
    var mpcSession: MCSession
    
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
    
    func setUpCards()
    {
        cards.removeAll()
        
        switch(sessionType)
        {
            case "Business Value":
                cards.append(Card(faceValue: "0"))
                cards.append(Card(faceValue: "½"))
            
                // Add Fibonacci numbers two to twelve
                for i in 2...12 {
                    cards.append(Card(faceValue: String(SwissArmyKnife.fibonacciOnIndex(UInt(i)))))
                }
            
                cards.append(Card(faceValue: "B"))
            break;
            case "Complexity":
                cards.append(Card(faceValue: "0"))
                cards.append(Card(faceValue: "½"))
                
                // Add Fibonacci numbers two to six
                for i in 2...6 {
                    cards.append(Card(faceValue: String(SwissArmyKnife.fibonacciOnIndex(UInt(i)))))
                }
                
                cards.append(Card(faceValue: "B"))
            default:
                print("There's a problem with the value of sessionType")
        }
        cards.append(Card(faceValue: "?"))
    }
}
