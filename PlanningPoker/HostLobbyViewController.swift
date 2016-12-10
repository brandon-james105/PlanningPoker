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

final class HostLobbyViewController: UIViewController, UITableViewDelegate, MPCManagerDelegate
{
    public var viewModel: IHostLobbyViewModel?
    
    @IBOutlet weak var votingSessionTitleBar: UINavigationItem!
    @IBOutlet weak var peerList: UITableView!
    @IBOutlet weak var beginVotingBtn: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        votingSessionTitleBar.title = self.viewModel?.sessionType
        peerList.delegate = self
        viewModel?.planningPokerService.mpcManager.delegate = self
        
        viewModel?.planningPokerService.mpcManager.browser.startBrowsingForPeers()
        viewModel?.planningPokerService.mpcManager.advertiser.startAdvertisingPeer()
        
        bindViewModel()
    }
    
    func bindViewModel()
    {
        viewModel?.voterNames.bind(to: peerList) { names, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "idCellPeer", for: indexPath)
            let user: MCPeerID = names[indexPath.row]
            cell.textLabel?.text = user.displayName
            return cell
        }
        
        beginVotingBtn.bnd_tap.observeNext { e in
            self.viewModel?.planningPokerService.sendSessionInit()
        }
        .disposeIn(bnd_bag)
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        viewModel?.planningPokerService.mpcManager.advertiser?.stopAdvertisingPeer()
        viewModel?.planningPokerService.mpcManager.browser?.stopBrowsingForPeers()
        viewModel?.planningPokerService.mpcManager.foundPeers.removeAll()
    }
    
    internal func foundPeer()
    {
        viewModel?.planningPokerService.mpcManager.browser.invitePeer((viewModel?.planningPokerService.mpcManager.foundPeers.last)!,
                                                 to: (viewModel?.votingSession.mpcSession)!,
                                                 withContext: nil,
                                                 timeout: 20)
    }
    
    internal func lostPeer(lostPeer peerID: MCPeerID)
    {
        for (index, aPeer) in (viewModel?.voterNames.enumerated())!
        {
            if aPeer == peerID
            {
                viewModel?.voterNames.remove(at: index)
                break
            }
        }
    }
    
    internal func connectedWithPeer(peerID: MCPeerID)
    {
        // Add them to the voterNames array
        viewModel?.voterNames.append(peerID)
    }
    
    internal func invitationWasReceived(fromPeer: MCPeerID)
    {
        // Do nothing, you are a host
    }
}
