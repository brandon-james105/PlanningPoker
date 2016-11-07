//
//  VoterSessionSelectorViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/29/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity

final class VoterSessionSelectorViewController : UIViewController, UITableViewDelegate, MPCManagerDelegate
{
    public var viewModel: IVoterSessionSelectorViewModel?
    @IBOutlet weak var sessionList: UITableView!
    
    override func viewDidLoad()
    {
        sessionList.delegate = self
        viewModel?.mpcManager.delegate = self
        viewModel?.mpcManager.advertiser.startAdvertisingPeer()
        
        bindViewModel()
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        viewModel?.mpcManager.advertiser.stopAdvertisingPeer()
    }
    
    func bindViewModel()
    {
        viewModel?.sessionInvitations.bind(to: sessionList) { names, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
            cell.textLabel?.text = names[indexPath.row].displayName
            return cell
        }
    }
    
    func foundPeer() { }
    
    func lostPeer(lostPeer peerID: MCPeerID) { }
    
    internal func connectedWithPeer(peerID: MCPeerID)
    {
        print("connected with \(peerID.displayName)")
    }
    
    internal func invitationWasReceived(fromPeer: MCPeerID)
    {
        print("Invitation was received from \(fromPeer.displayName)")
        viewModel?.sessionInvitations.append(fromPeer)
    }
    
    // Selecting a table view item
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        let selectedPeerDisplayName: String = (viewModel?.sessionInvitations[indexPath.row])!.displayName
        
        let alert = UIAlertController(title: "", message: "Connect to \(selectedPeerDisplayName)'s session?", preferredStyle: UIAlertControllerStyle.alert)
        
        let acceptAction: UIAlertAction = UIAlertAction(title: "Connect", style: UIAlertActionStyle.default) { (alertAction) -> Void in
            self.viewModel?.mpcManager.invitationHandler(true, self.viewModel?.mpcManager.session)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.viewModel?.mpcManager.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
}
