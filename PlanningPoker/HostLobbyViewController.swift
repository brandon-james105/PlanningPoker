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

    var isAdvertising: Bool!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        votingSessionTitleBar.title = self.viewModel?.sessionType
        peerList.delegate = self
        viewModel?.mpcManager.delegate = self
        
        viewModel?.mpcManager.browser.startBrowsingForPeers()
        viewModel?.mpcManager.advertiser.startAdvertisingPeer()
        
        isAdvertising = true
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
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        viewModel?.mpcManager.advertiser?.stopAdvertisingPeer()
        viewModel?.mpcManager.browser?.stopBrowsingForPeers()
        viewModel?.mpcManager.foundPeers.removeAll()
    }
    
    internal func foundPeer()
    {
        let peer = viewModel?.mpcManager.foundPeers.last
        let session = viewModel?.mpcManager.session
        viewModel?.mpcManager.browser.invitePeer(peer!, to: session!, withContext: nil, timeout: 20)
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
    
    internal func invitationWasReceived(fromPeer: String)
    {
        // Do nothing, you are a host
    }
}
