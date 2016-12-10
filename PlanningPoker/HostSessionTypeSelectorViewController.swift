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
    @IBOutlet weak var featureDiscussionLabel: UILabel!
    
    override func viewDidLoad()
    {
        featureDiscussionLabel.text = "There are no features to discuss"
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        let vmFeatures = self.viewModel?.planningPokerService.getSession().features
        let featureCount: Int = (vmFeatures?.count)!
        
        if (featureCount > 0)
        {
            featureDiscussionLabel.text = "There are \(featureCount) features to discuss"
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.destination is HostLobbyViewController)
        {
            let sender = sender as! UIButton;
            let hostLobbyVC = segue.destination as! HostLobbyViewController;
            hostLobbyVC.viewModel!.sessionType = sender.currentTitle!
        }
    }
}
