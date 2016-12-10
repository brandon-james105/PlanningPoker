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
    var user: User

    var container: Container = {
        let container = SwinjectStoryboard.defaultContainer
        
        // Service
        
        container.register(MPCManager.self) { r
            in MPCManager.sharedInstance
        }
        
        container.register(PlanningPokerService.self) { r
            in PlanningPokerService.sharedInstance
        }
        
        // View models
        
        container.register(VotingCardViewModel.self) { r
            in VotingCardViewModel(planningPokerService: container.resolve(PlanningPokerService.self)!)
        }
        
        container.register(IUserRoleSelectorViewModel.self) { r
            in UserRoleSelectorViewModel(mpcManager: container.resolve(MPCManager.self)!)
        }
        
        container.register(IHostSessionTypeSelectorViewModel.self) { r
            in HostSessionTypeSelectorViewModel(planningPokerService: container.resolve(PlanningPokerService.self)!)
        }
        
        container.register(IHostLobbyViewModel.self) { r
            in HostLobbyViewModel(planningPokerService: container.resolve(PlanningPokerService.self)!)
        }
        
        container.register(IVoterSessionSelectorViewModel.self) { r
            in VoterSessionSelectorViewModel(planningPokerService: container.resolve(PlanningPokerService.self)!)
        }
        
        container.register(IHostFeaturesInputViewModel.self) { r
            in HostFeaturesInputViewModel(planningPokerService: container.resolve(PlanningPokerService.self)!)
        }
        
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
            c.viewModel = r.resolve(VotingCardViewModel.self)
        }
        
        container.registerForStoryboard(VotingViewController.self) {
            r, c in
        }
        
        container.registerForStoryboard(HostFeaturesInputViewController.self) {
            r, c in
            c.viewModel = r.resolve(IHostFeaturesInputViewModel.self)!
        }
        
        return container
    }()
    
    override init()
    {
        user = User(name: UIDevice.current.name)
    }
    
    private func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = UIColor.white
        window.makeKeyAndVisible()
        self.window = window
        
        user.setName(name: UIDevice.current.name)
        
        let bundle = Bundle(for: UserRoleSelectorViewController.self)
        let storyboard = SwinjectStoryboard.create(name: "Main",
                                                   bundle: bundle,
                                                   container: container)
        window.rootViewController = storyboard.instantiateInitialViewController()
        
        return true
    }
}
