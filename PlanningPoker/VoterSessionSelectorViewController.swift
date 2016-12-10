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

final class VoterSessionSelectorViewController: UIViewController, UITableViewDelegate, MPCManagerDelegate
{
    public var viewModel: IVoterSessionSelectorViewModel?
    @IBOutlet weak var sessionList: UITableView!
    
    override func viewDidLoad()
    {
        sessionList.delegate = self
        
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        viewModel?.planningPokerService.mpcManager.delegate = self
        viewModel?.planningPokerService.mpcManager.advertiser.startAdvertisingPeer()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        viewModel?.planningPokerService.mpcManager.advertiser.stopAdvertisingPeer()
        viewModel?.planningPokerService.getSession().mpcSession.disconnect()
    }
    
    func bindViewModel()
    {
        viewModel?.sessionInvitations.bind(to: sessionList) { names, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "sessionCell", for: indexPath)
            cell.textLabel?.text = names[indexPath.row].displayName
            return cell
        }
    }
    
    // This is here to accomodate for NotificationCenter's addObserver selector parameter
    @objc func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        _ = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        // Check if there's an entry with the "message" key.
        if dataDictionary["message"] != nil {
            if (dataDictionary["message"] == "_start_session_")
            {
                OperationQueue.main.addOperation { () -> Void in
                    self.performSegue(withIdentifier: "sessionStart", sender: self)
                }
            }
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
            self.viewModel?.planningPokerService.mpcManager.invitationHandler(true, self.viewModel?.planningPokerService.mpcManager.session)
        }
        
        let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
            self.viewModel?.planningPokerService.mpcManager.invitationHandler(false, nil)
        }
        
        alert.addAction(acceptAction)
        alert.addAction(declineAction)
        
        OperationQueue.main.addOperation { () -> Void in
            self.present(alert, animated: true, completion: nil)
        }
    }
}
