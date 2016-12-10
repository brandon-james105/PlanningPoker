//
//  UserProfileViewController.swift
//  PlanningPoker
//
//  Created by Brandon James on 11/10/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit
import Bond

class UserProfileViewController: UIViewController
{
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var saveBtn: UIButton!

    override func viewDidLoad()
    {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userNameTextField.text = appDelegate.user.name
        
        saveBtn.bnd_tap.observeNext { e in
            appDelegate.user.setName(name: self.userNameTextField.text!)
        }.disposeIn(bnd_bag)
    }
    
}
