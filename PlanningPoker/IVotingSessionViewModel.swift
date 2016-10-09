//
//  ISessionViewModel.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import Bond

protocol IVotingSessionViewModel
{
    // Write the implementation of the viewmodel here.
    var sessionType: String { get set }
    var voterNames: ObservableArray<User> { get }
    var session: IConnectionManager { get }

    func startSession()
}
