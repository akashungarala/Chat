//
//  AppDelegate.swift
//  Chat
//
//  Created by Akash Ungarala on 10/27/16.
//  Copyright © 2016 Akash Ungarala. All rights reserved.
//

import UIKit
import CoreData
import Parse
import ParseUI
import ParseFacebookUtils
import FacebookSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        Parse.setApplicationId("DXsvTSLgsKT03gSSqy6V5KbLwVpgfEjmEsKzzQUP",
                               clientKey: "BXAzmCJhMtIVWhLVEiKIMzPCA5XI0Nt9NwvAOPVd")
        PFFacebookUtils.initializeFacebook()
//        return FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {}

    func applicationDidEnterBackground(_ application: UIApplication) {}

    func applicationWillEnterForeground(_ application: UIApplication) {}

    func applicationDidBecomeActive(_ application: UIApplication) {
        FBAppEvents.activateApp()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    private func application(application: UIApplication, openURL url: URL, options: [String: AnyObject]) -> Bool {
        return FBAppCall.handleOpen(url, sourceApplication: options["UIApplicationOpenURLOptionsSourceApplicationKey"] as! String)
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        FBAppCall.handleDidBecomeActive(with: PFFacebookUtils.session())
    }

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}
