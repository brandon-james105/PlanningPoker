//
//  HostFeaturesInputViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 11/26/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit
import Bond

class HostFeaturesInputViewController: UIViewController, UITableViewDelegate
{
    @IBOutlet weak var featuresTableView: UITableView!
    @IBOutlet weak var saveFeaturesBtn: UIButton!
    @IBOutlet weak var addFeatureBtn: UIButton!
    @IBOutlet weak var newFeatureTextView: UITextField!

    public var viewModel: IHostFeaturesInputViewModel?
    var features = MutableObservableArray<String>([])
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        bindViewModel()
    }
    
    private func bindViewModel()
    {
        for (_, element) in (self.viewModel?.planningPokerService.getSession().features.enumerated())!
        {
            features.append(element)
        }
        
        features.bind(to: featuresTableView) { features, indexPath, tableView in
            let cell = tableView.dequeueReusableCell(withIdentifier: "featureCell", for: indexPath)
            cell.textLabel?.text = features[indexPath.row]
            return cell
        }
        
        newFeatureTextView.bnd_text.observeNext { text in
            self.addFeatureBtn.isEnabled = (text!.isEmpty) ? false : true
        }.disposeIn(bnd_bag)
        
        addFeatureBtn.bnd_tap.observeNext { e in
            self.features.append(self.newFeatureTextView.text!)
            self.newFeatureTextView.text = ""
            self.addFeatureBtn.isEnabled = false
        }.disposeIn(bnd_bag)
        
        saveFeaturesBtn.bnd_tap.observeNext { e in
            self.viewModel?.planningPokerService.getSession().features.removeAll()
            for (_, element) in self.features.enumerated()
            {
                self.viewModel?.planningPokerService.getSession().features.append(element)
            }
        }.disposeIn(bnd_bag)
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
