//
//  CardManager.swift
//  PlanningPoker
//
//  Created by Brandon James on 12/11/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation

class CardManager
{
    static func setUpCards(forType: String) -> [Card]
    {
        var cards: [Card] = []
        
        switch(forType)
        {
        case "Business Value":
            cards.append(Card(faceValue: "0"))
            cards.append(Card(faceValue: "½"))
            
            // Add Fibonacci numbers two to twelve
            for i in 2...12 {
                cards.append(Card(faceValue: String(self.fibonacciOnIndex(UInt(i)))))
            }
            
            cards.append(Card(faceValue: "B"))
            break;
        case "Complexity":
            cards.append(Card(faceValue: "0"))
            cards.append(Card(faceValue: "½"))
            
            // Add Fibonacci numbers two to six
            for i in 2...6 {
                cards.append(Card(faceValue: String(self.fibonacciOnIndex(UInt(i)))))
            }
            
            cards.append(Card(faceValue: "B"))
        default:
            print("There's a problem with the value of sessionType")
        }
        cards.append(Card(faceValue: "?"))
        return cards
    }
    
    static func getAverageValueOfCards(cards: [Card]) -> Double
    {
        var sum: Double = 0
        
        for card in cards
        {
            sum += card.effortValue!
        }
        let average = sum / Double(cards.count)
        return average
    }
    
    static func fibonacciOnIndex(_ n:UInt)->UInt
    {
        if ((n == 0) || (n == 1))
        {
            return n
        }
        else
        {
            return fibonacciOnIndex(n - 1) + fibonacciOnIndex(n - 2);
        }
    }
}
