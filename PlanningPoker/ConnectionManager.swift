//
//  ConnectionManager.swift
//  Planning Poker
//
//  Created by Brandon James on 9/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import MultipeerConnectivity

class ConnectionManager : NSObject, IConnectionManager
{
    // Service type must be a unique string, at most 15 characters long
    // and can contain only ASCII lowercase letters, numbers and hyphens.
    private let ServiceType = "planning-poker"
    
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let serviceAdvertiser : MCNearbyServiceAdvertiser
    private let serviceBrowser : MCNearbyServiceBrowser
    
    var delegate : ConnectionManagerDelegate?
    
    override init()
    {
        self.serviceAdvertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: ServiceType)
        self.serviceBrowser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: ServiceType)
        super.init()
        self.serviceAdvertiser.delegate = self
    }
    
    func sendCard(cardName : String) {
        NSLog("%@", "sendCard: \(cardName)")
        
        if session.connectedPeers.count > 0
        {
            do {
                try self.session.send(cardName.data(using: String.Encoding.utf8)!, toPeers: session.connectedPeers, with: MCSessionSendDataMode.reliable)
            } catch _ {
                print("error caught sending data")
            }
        }
        
    }
    
    func start()
    {
        self.serviceAdvertiser.startAdvertisingPeer()
        self.serviceBrowser.startBrowsingForPeers()
    }
    
    func stop()
    {
        self.serviceAdvertiser.stopAdvertisingPeer()
        self.serviceBrowser.stopBrowsingForPeers()
    }
    
    deinit {
        stop()
    }
    
    lazy var session : MCSession = {
        let session = MCSession(peer: self.myPeerId, securityIdentity: nil, encryptionPreference: MCEncryptionPreference.required)
        session.delegate = self
        return session
    }()
    
}

extension ConnectionManager : MCNearbyServiceAdvertiserDelegate
{
    @available(iOS 7.0, *)
    public func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext context: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void)
    {
        print("%@", "didReceiveInvitationFromPeer \(peerID)")
    }
    
    func advertiser(_ advertiser: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer error: Error) {
        NSLog("%@", "didNotStartAdvertisingPeer: \(error)")
    }
    
    func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession?) -> Void)!)
    {
        NSLog("%@", "didReceiveInvitationFromPeer \(peerID)")
        invitationHandler(true, self.session)
    }
}

extension ConnectionManager : MCNearbyServiceBrowserDelegate
{
    @available(iOS 7.0, *)
    public func browser(_ browser: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo info: [String : String]?)
    {
        NSLog("%@", "foundPeer: \(peerID)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, didNotStartBrowsingForPeers error: Error) {
        NSLog("%@", "didNotStartBrowsingForPeers: \(error)")
    }
    
    func browser(_ browser: MCNearbyServiceBrowser, lostPeer peerID: MCPeerID) {
        NSLog("%@", "lostPeer: \(peerID)")
    }
    
}

extension ConnectionManager : MCSessionDelegate
{
    @available(iOS 7.0, *)
    public func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL, withError error: Error?)
    {
        NSLog("%@", "didFinishReceivingResourceWithName")
    }
    
    public func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress)
    {
        NSLog("%@", "didStartReceivingResourceWithName")
    }

    public func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID)
    {
        NSLog("%@", "didReceiveStream")
    }
    
    public func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState)
    {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.stringValue())")
    }

    public func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID)
    {
        NSLog("%@", "didReceiveData: \(data)")
    }
    
    func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState)
    {
        NSLog("%@", "peer \(peerID) didChangeState: \(state.stringValue())")
        self.delegate?.connectedDevicesChanged(manager: self, connectedDevices: session.connectedPeers.map({$0.displayName}))
    }
    
    func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!)
    {
        NSLog("%@", "didReceiveData: \(data.length) bytes")
        let str = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue) as! String
        self.delegate?.cardSent(manager: self, cardString: str)
    }
    
}

extension MCSessionState
{
    
    func stringValue() -> String {
        switch(self) {
        case .notConnected: return "NotConnected"
        case .connecting: return "Connecting"
        case .connected: return "Connected"
        default: return "Unknown"
        }
    }
    
}

protocol ConnectionManagerDelegate
{
    func connectedDevicesChanged(manager : ConnectionManager, connectedDevices: [String])
    func cardSent(manager : ConnectionManager, cardString: String)
    
}
