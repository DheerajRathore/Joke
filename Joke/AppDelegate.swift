//
//  AppDelegate.swift
//  MVP_Medium
//
//  Created by Dheeraj Rathore  on 31/10/23.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: PROPERTIES.
    var window: UIWindow?
    var coreDataStack: CoreDataStack!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)
        // create joke list view controller.
        let jokeListVC = JokeListViewController()
        // initiate core data stack.
        coreDataStack = CoreDataStack()
        let model = JokeListModel(moContext: coreDataStack.moContext)
        let presenter = JokesListPresenter(view: jokeListVC, model: model)
        jokeListVC.inject(presenter: presenter)
        // set jokeListVC as a root.
        window?.rootViewController = jokeListVC
        window?.makeKeyAndVisible()
        return true
    }
}

