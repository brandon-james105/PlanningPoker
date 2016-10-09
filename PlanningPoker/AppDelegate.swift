//
//  AppDelegate.swift
//  PlanningPoker
//
//  Created by Brandon James on 10/8/16.
//  Copyright © 2016 Brandon James. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var container: Container = {
        let container = SwinjectStoryboard.defaultContainer
        // Service
        
        container.register(IConnectionManager.self) { r
            in ConnectionManager()
        }
        
        // View models
        
        container.register(IUserRoleSelectorViewModel.self) { r
            in UserRoleSelectorViewModel()
        }
        
        container.register(ISessionSelectorViewModel.self) { r
            in SessionSelectorViewModel()
        }
        
        container.register(IVotingSessionViewModel.self) { r
            in VotingSessionViewModel(session: container.resolve(IConnectionManager.self)!)
        }
        
        // Views
        container.registerForStoryboard(UserRoleSelectorViewController.self) {
            r, c in
            c.viewModel = r.resolve(IUserRoleSelectorViewModel.self)!
        }
        
        container.registerForStoryboard(SessionSelectorViewController.self) {
            r, c in
            c.viewModel = r.resolve(ISessionSelectorViewModel.self)!
        }
        
        container.registerForStoryboard(VotingSessionViewController.self) {
            r, c in
            c.viewModel = r.resolve(IVotingSessionViewModel.self)!
        }
        
        return container
    }()
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        
        let bundle = Bundle(for: UserRoleSelectorViewController.self)
        let storyboard = SwinjectStoryboard.create(name: "Main",
                                                   bundle: bundle,
                                                   container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
}
