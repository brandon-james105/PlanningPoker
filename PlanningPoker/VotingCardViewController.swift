//
//  VotingCardViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/17/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import Foundation
import UIKit

final class VotingCardViewController: UIViewController
{
    public var viewModel: VotingCardViewModel?
    @IBOutlet weak var votingCardDisplay: UICollectionView!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        votingCardDisplay!.register(CardCell.self, forCellWithReuseIdentifier: "votingCardCell")
        
        viewModel?.cards.bind(to: votingCardDisplay) { array, indexPath, votingCardDisplay in
            let cell = votingCardDisplay.dequeueReusableCell(withReuseIdentifier: "votingCardCell", for: indexPath) as! CardCell
            let card = array[indexPath.item]

            cell.textLabel?.text = card.face
//            cell.textLabel?.bnd_tap.observeNext { e in
//                print("clicked \(card.face), which has a value of: \(card.effortValue)")
//            }
//            .disposeIn(cell.bnd_bag)
            
            return cell
        }
    }
}
