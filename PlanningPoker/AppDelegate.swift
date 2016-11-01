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
        
        container.register(MPCManager.self) { r
            in MPCManager.sharedInstance
        }
        
        // View models
        
        container.register(IUserRoleSelectorViewModel.self) { r
            in UserRoleSelectorViewModel()
        }
        
        container.register(IHostSessionTypeSelectorViewModel.self) { r
            in HostSessionTypeSelectorViewModel()
        }
        
        container.register(IHostLobbyViewModel.self) { r
            in HostLobbyViewModel(mpcManager: container.resolve(MPCManager.self)!)
        }
        
        container.register(IVoterSessionSelectorViewModel.self) { r
            in VoterSessionSelectorViewModel(mpcManager: container.resolve(MPCManager.self)!)
        }
        
//        container.register(IVotingCardViewModel.self) { r
//            in VotingCardViewModel()
//        }
        
        // Views
        container.registerForStoryboard(UserRoleSelectorViewController.self) {
            r, c in
            c.viewModel = r.resolve(IUserRoleSelectorViewModel.self)!
        }
        
        container.registerForStoryboard(HostSessionTypeSelectorViewController.self) {
            r, c in
            c.viewModel = r.resolve(IHostSessionTypeSelectorViewModel.self)!
        }
        
        container.registerForStoryboard(HostLobbyViewController.self) {
            r, c in
            c.viewModel = r.resolve(IHostLobbyViewModel.self)!
        }
        
        container.registerForStoryboard(VoterSessionSelectorViewController.self) {
            r, c in
            c.viewModel = r.resolve(IVoterSessionSelectorViewModel.self)!
        }
        
        container.registerForStoryboard(VotingCardViewController.self) {
            r, c in
//            c.viewModel = r.resolve(IVotingCardViewModel.self)
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
