//
//  UserRoleSelectorViewController.swift
//  Planning Poker
//
//  Created by Brandon James on 9/13/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit
import MultipeerConnectivity

final class UserRoleSelectorViewController: UIViewController
{
    public var viewModel: IUserRoleSelectorViewModel?
    
    @IBOutlet weak var toHostButton: UIButton!
    @IBOutlet weak var toVoterButton: UIButton!
    @IBOutlet weak var userNameButton: UIButton!
    
    override func viewDidAppear(_ animated: Bool)
    {
        setButtonTitleToUserName()
        PlanningPokerService.sharedInstance.getSession().mpcSession.disconnect()
    }
    
    private func setButtonTitleToUserName()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.user;
        userNameButton.setTitle(user.name, for: UIControlState.normal)
        viewModel?.mpcManager.setPeer(peer: appDelegate.user.myPeer)
    }
    
}
