//
//  AppDelegate.swift
//  ToDoList
//
//  Created by YashraJ Gujar on 25/03/19.
//  Copyright © 2019 YashraJ. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("1") //1
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {

       // print("3") //3
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {

       // print("4") //4
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {

        print("5") //5
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
       
      //  print("2") //2
    }
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
 
        let container = NSPersistentContainer(name: "DataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {

                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
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


