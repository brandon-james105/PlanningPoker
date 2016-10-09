//
//  VotingSessionViewController.swift
//  Planning Poker
//
//  Created by Brandon James on 9/14/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit
import Bond
import MultipeerConnectivity

final class VotingSessionViewController: UIViewController
{
    public var viewModel: IVotingSessionViewModel?
    
    @IBOutlet weak var votingSessionTitleBar: UINavigationItem!
    
    override func viewDidLoad()
    {
        votingSessionTitleBar.title = self.viewModel?.sessionType
        viewModel?.startSession()
    }
    
}
extension VotingSessionViewController : MCNearbyServiceBrowserDelegate
{
    public func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?)
    {
        NSLog("%@", "foundPeer: \(peerID)")
        NSLog("%@", "invitePeer: \(peerID)")
//        browser.invitePeer(peerID, to: self.viewModel?.session as! MCSession, withContext: nil, timeout: 10)
    }
    
}
