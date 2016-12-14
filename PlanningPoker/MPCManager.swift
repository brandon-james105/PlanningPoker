//
//  MPCManager.swift
//  MPCRevisited
//
//  Created by Gabriel Theodoropoulos on 11/1/15.
//  Copyright (c) 2015 Appcoda. All rights reserved.
//
// Tutorial: (https://www.appcoda.com/chat-app-swift-tutorial/)

import UIKit
import MultipeerConnectivity

protocol MPCManagerDelegate
{
    func foundPeer()
    
    func lostPeer(lostPeer peerID: MCPeerID)
    
    func invitationWasReceived(fromPeer: MCPeerID)
    
    func connectedWithPeer(peerID: MCPeerID)
    
    func notConnectedWithPeer(peerID: MCPeerID)
}

class MPCManager: NSObject, MCSessionDelegate, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate
{
    var delegate: MPCManagerDelegate?

    var session: MCSession!
    
    var peer: MCPeerID!
    
    var browser: MCNearbyServiceBrowser!
    
    var advertiser: MCNearbyServiceAdvertiser!
    
    var foundPeers = [MCPeerID]()
    
    var invitationHandler: ((Bool, MCSession?)->Void)!
    
    static let sharedInstance = MPCManager()
    
    private override init()
    {
        super.init()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let user = appDelegate.user
        peer = user.myPeer
        
        self.setPeer(peer: user.myPeer)
    }
    
    func setPeer(peer: MCPeerID)
    {
        self.peer = peer
        session = MCSession(peer: self.peer)
        session.delegate = self
        
        browser = MCNearbyServiceBrowser(peer: self.peer, serviceType: "planpoker-mpc")
        browser.delegate = self
        
        advertiser = MCNearbyServiceAdvertiser(peer: self.peer, discoveryInfo: nil, serviceType: "planpoker-mpc")
        advertiser.delegate = self
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)
    {
        print("received data from peer \(peerID.displayName)")
        let dictionary: [String: AnyObject] = ["data": data as AnyObject, "fromPeer": peerID]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: dictionary)
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?)
    {
        print("Finished receiving resource from " + peerID.displayName)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void)
    {
        print("Received invitation from " + peerID.displayName)
        self.invitationHandler = invitationHandler
        delegate?.invitationWasReceived(fromPeer: peerID)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?)
    {
        print("Found peer: " + peerID.displayName)
        foundPeers.append(peerID)
        delegate?.foundPeer()
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID)
    {
        print("Lost peer: " + peerID.displayName)
        
        for (index, aPeer) in foundPeers.enumerated()
        {
            if aPeer == peerID
            {
                foundPeers.remove(at: index)
                break
            }
        }
        
        delegate?.lostPeer(lostPeer: peerID)
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error)
    {
        print(error.localizedDescription)
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: Data!, invitationHandler: ((Bool, MCSession?) -> Void)!)
    {
        self.invitationHandler = invitationHandler
        delegate?.invitationWasReceived(fromPeer: peerID)
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error)
    {
        print(error.localizedDescription)
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState)
    {
        switch state {
        case MCSessionState.connected:
            print("Connected to session: \(session)")
            delegate?.connectedWithPeer(peerID: peerID)
            
        case MCSessionState.connecting:
            print("Connecting to session: \(session)")
        default:
            delegate?.notConnectedWithPeer(peerID: peerID)
            print("Did not connect to session: \(session)")
        }
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) { }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) { }
    
    func sendData(dictionaryWithData dictionary: Dictionary<String, String>, toPeers targetPeers: [MCPeerID]) -> Bool
    {
        let dataToSend = NSKeyedArchiver.archivedData(withRootObject: dictionary)
        
        do {
            try session.send(dataToSend, toPeers: targetPeers, with: MCSessionSendDataMode.reliable)
        }
        catch MCError.invalidParameter {
            print("invalid parameter")
            return false
        }
        catch _ {
            return false
        }
        
        return true
    }
    
}
