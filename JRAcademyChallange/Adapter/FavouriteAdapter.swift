//
//  FavouriteAdapter.swift
//  JRAcademyChallange
//
//  Created by Burak GÖĞÜŞ on 8.06.2023.
//

import Foundation
import UIKit
import Carbon
import CoreData
class FavouriteAdapter: UITableViewAdapter{
  weak var favouritesController: FavouritesViewController?

  func tableView(_ tableView: UITableView, canFocusRowAt indexPath: IndexPath) -> Bool {

    return true
  }


  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
          return
        }
        let managedObjectContext: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Favourite")
        fetchRequest.predicate = NSPredicate(format: "gameid == %d", favouritesController?.favouritesGames[indexPath.row] ?? "")
        do {
          let results = try managedObjectContext.fetch(fetchRequest) as! [NSManagedObject]
          if let object = results.first {
            managedObjectContext.delete(object)
            try managedObjectContext.save()
          }
        } catch let error as NSError {
          print("Could not delete data: \(error), \(error.userInfo)")
        }
        favouritesController?.getFavourites()
        tableView.reloadData() // Update the table view after deletion
      }
    }
}
