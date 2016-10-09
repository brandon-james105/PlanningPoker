//
//  UserRoleSelectorViewController.swift
//  Planning Poker
//
//  Created by Brandon James on 9/13/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit

final class UserRoleSelectorViewController: UIViewController
{
    public var viewModel: IUserRoleSelectorViewModel?
    
    @IBOutlet weak var toHostButton: UIButton!
    @IBOutlet weak var toVoterButton: UIButton!
    
    override func viewDidLoad()
    {
        print("Role Selection was loaded")
    }
    
}
