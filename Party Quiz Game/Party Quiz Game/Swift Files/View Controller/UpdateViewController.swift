//
//  UpdateViewController.swift
//  Party Quiz Game
//
//  Created by Ernesto De Crecchio on 14/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit
import CloudKit
import CoreData

class UpdateViewController: UIViewController {
  
  var cloudKitDatabase = CloudKitQuestions.shared
  
  let entityNameQ = "Question"
  
  let context = CoreDataManager.shared.createContext()
  let entity = CoreDataManager.shared.createEntity(nameEntity: "Question")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    cloudKitDatabase.questioningDelegate = self
  }
  
  var loadingView: UIView?
  
  override func viewDidAppear(_ animated: Bool) {
    cloudKitDatabase.resetLocalArray()
    //Make loading view
    self.loadingView = UIView(frame: self.view.frame)
    loadingView!.alpha = 0.2
    loadingView!.backgroundColor = UIColor.black
    self.view.addSubview(loadingView!)
    
    cloudKitDatabase.downloadAllQuestions()
  }
  
  func downloadEnded() {
    syncronizeDatabases()
    self.loadingView?.removeFromSuperview()
    performSegue(withIdentifier: "afterDownload", sender: nil)
  }
  
  func syncronizeDatabases() {
    let requestDomanda = NSFetchRequest<NSFetchRequestResult>(entityName: entityNameQ)
    requestDomanda.returnsObjectsAsFaults = false
    do {
      let result = try context.fetch(requestDomanda)
      for data in result as! [NSManagedObject] {
        CoreDataManager.shared.question.append(data)
      }
    } catch {
      print("Failed")
    }
  }
  
  
}
