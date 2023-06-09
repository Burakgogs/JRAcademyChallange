//
//  AppDelegate.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 1.06.2023.
//

import UIKit
import Carbon
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    return true
  }

  // MARK: UISceneSession Lifecycle

  func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {

    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
  }

  func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
  }

//  lazy var persistentContainer: NSPersistentContainer = {
//
//  let container = NSPersistentContainer(name: "JRAcademyChallange")
//  container.loadPersistentStores(completionHandler: { (storeDescription, error) in
//  if let error = error as NSError? {
//    fatalError("Unresolved error \(error), \(error.userInfo)")
//
//  }
//  })
//    return container
//  }()

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
  lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "JRAcademyChallange")

      func resetPersistentContainer() {
          container.persistentStoreDescriptions.forEach { description in
              do {
                guard let url = description.url else {return}
                  try container.persistentStoreCoordinator.destroyPersistentStore(at: url, ofType: description.type, options: description.options)
                  try container.persistentStoreCoordinator.addPersistentStore(ofType: description.type, configurationName: description.configuration, at: description.url, options: description.options)
              } catch {
                  fatalError("Persistent store reset error-------: \(error)")
              }
          }
      }

      container.loadPersistentStores(completionHandler: { (storeDescription, error) in
          if let error = error as NSError? {
              print("Persistent store loading error: \(error), \(error.userInfo)")

              // Hata durumunda persistentContainer'ı yeniden başlat
              resetPersistentContainer()
          }
      })

      return container
  }()
  

}

