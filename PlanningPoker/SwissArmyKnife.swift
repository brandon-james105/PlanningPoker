//
//  SwissArmy.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation

class SwissArmyKnife
{
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
