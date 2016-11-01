//
//  SessionSelectorViewController.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit

final class HostSessionTypeSelectorViewController: UIViewController
{
    public var viewModel: IHostSessionTypeSelectorViewModel?
    
    @IBOutlet weak var complexityButton: UIButton!
    @IBOutlet weak var businessValueButton: UIButton!
    
    override func viewDidLoad()
    {
        print("Session Selection was loaded")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (sender is UIButton)
        {
            let sender = sender as! UIButton;
            let hostLobbyVC = segue.destination as! HostLobbyViewController;
            hostLobbyVC.viewModel!.sessionType = sender.currentTitle!
        }
    }
}
