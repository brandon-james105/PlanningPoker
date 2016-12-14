//
//  VotingViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/17/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import UIKit
import MultipeerConnectivity
import Bond

final class VotingViewController: UIViewController
{
    public var viewModel: IVotingViewModel?
    
    @IBOutlet weak var votesTableView: UITableView!
    @IBOutlet weak var averageLabel: UILabel!
    @IBOutlet weak var featureNameLabel: UILabel!
    @IBOutlet weak var nextFeatureBtn: UIButton!
    
    var features: [String]?
    var currentFeature = 0
    
    override func viewDidAppear(_ animated: Bool)
    {
        self.features = viewModel?.planningPokerService.getSession().features
        if ((self.features?.count)! > 0)
        {
            featureNameLabel.text = self.features?[currentFeature]
            let feature = self.features?[self.currentFeature]
            viewModel?.planningPokerService.sendFeature(feature: feature!)
        }
        else
        {
            OperationQueue.main.addOperation { () -> Void in
                self.featureNameLabel.text = "There are no features to discuss"
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleMPCReceivedDataWithNotification(notification:)), name: NSNotification.Name(rawValue: "receivedMPCDataNotification"), object: nil)
        
        bindViewModel()
    }
    
    func bindViewModel()
    {
        viewModel?.votes.bind(to: votesTableView) { votes, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "voteCell", for: indexPath)
            cell.textLabel?.text = String(votes[indexPath.row].face)
            return cell
        }
        
        nextFeatureBtn.bnd_tap.observeNext { e in
            if (self.currentFeature + 1 < (self.features?.count)!)
            {
                self.currentFeature += 1
                let feature = self.features?[self.currentFeature]
                OperationQueue.main.addOperation { () -> Void in
                    self.featureNameLabel.text = feature
                }
                self.viewModel?.planningPokerService.sendFeature(feature: feature!)
            }
            else
            {
                self.nextFeatureBtn.setTitle("Finish Session", for: .normal)
                if (self.nextFeatureBtn.titleLabel?.text == "Finish Session")
                {
//                    OperationQueue.main.addOperation { () -> Void in
//                        self.performSegue(withIdentifier: "toResults", sender: self)
//                    }
                }
            }
        }
        .disposeIn(bnd_bag)
    }
    
    // This is here to accomodate for NotificationCenter's addObserver selector parameter
    @objc func handleMPCReceivedDataWithNotification(notification: NSNotification)
    {
        // Get the dictionary containing the data and the source peer from the notification.
        let receivedDataDictionary = notification.object as! Dictionary<String, AnyObject>
        
        // "Extract" the data and the source peer from the received dictionary.
        let data = receivedDataDictionary["data"] as? NSData
        _ = receivedDataDictionary["fromPeer"] as! MCPeerID
        
        // Convert the data (NSData) into a Dictionary object.
        let dataDictionary = NSKeyedUnarchiver.unarchiveObject(with: data! as Data) as! Dictionary<String, String>
        
        if dataDictionary["card"] != nil
        {
            let card = Card(faceValue: dataDictionary["card"]!)
            self.viewModel?.votes.append(card)
            
            let averageValue = CardManager.getAverageValueOfCards(cards: (self.viewModel?.votes.array)!)
            OperationQueue.main.addOperation { () -> Void in
                self.averageLabel.text = String(format: "Average for votes (%.2f)", averageValue)
            }
        }
    }
}
