//
//  VotingCardViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/17/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import UIKit
import Bond
import MultipeerConnectivity

final class VotingCardViewController: UICollectionViewController
{
    public var viewModel: VotingCardViewModel?
    @IBOutlet weak var votingCardDisplay: UICollectionView!
    var headerView: FeatureHeader?
    var feature: String = ""
    var hasVoted = false
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        collectionView?.delegate = self
        collectionView?.dataSource = self
        
        viewModel?.cards.bind(to: votingCardDisplay) { array, indexPath, votingCardDisplay in
            let cell = votingCardDisplay.dequeueReusableCell(withReuseIdentifier: "votingCardCell", for: indexPath) as! CardCell
            let card = array[indexPath.item]
            cell.textLabel?.text = card.face
            return cell
        }
        
        headerView?.featureLabel.text = "Feature not loaded yet"
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
    }
    
    @objc func handleMPCReceivedDataWithNotification(notification: NSNotification) {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        _ = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        if dataDictionary["card"] != nil {
            self.feature = dataDictionary["card"]!
            OperationQueue.main.addOperation { () -> Void in
                self.headerView?.featureLabel.text = self.feature
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            self.headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: "featureHeader",
                                                                             for: indexPath) as? FeatureHeader
            self.headerView?.featureLabel.text = "Feature not loaded yet"
            return self.headerView!
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {
        if (!self.hasVoted)
        {
            let card: Card = (viewModel?.cards[indexPath.item])!
            let cell = collectionView.cellForItem(at: indexPath) as! CardCell
            
            let alert = UIAlertController(title: "", message: "Vote \(card.face)?", preferredStyle: UIAlertControllerStyle.alert)
        
            let acceptAction: UIAlertAction = UIAlertAction(title: "Send", style: UIAlertActionStyle.default) { (alertAction) -> Void in
                self.viewModel?.planningPokerService.sendCard(card: card)
                cell.isUserInteractionEnabled = false
                cell.backgroundColor = UIColor.blue
                cell.textLabel.textColor = UIColor.white
                self.hasVoted = true
            }
        
            let declineAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (alertAction) -> Void in
                print("Decided not to vote")
            }
        
            alert.addAction(acceptAction)
            alert.addAction(declineAction)
        
            OperationQueue.main.addOperation { () -> Void in
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
