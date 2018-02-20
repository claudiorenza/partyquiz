//
//  StartViewController.swift
//  Party Quiz Game
//
//  Created by Ernesto De Crecchio on 15/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
  
  @IBOutlet weak var startLabel: UILabel!
  @IBOutlet weak var lastStartLabel: UILabel!
  @IBOutlet weak var nowDateLabel: UILabel!
  @IBOutlet weak var passedDaysLabel: UILabel!
  @IBOutlet weak var lastUpdateLabel: UILabel!
  @IBOutlet weak var needsUpdateLabel: UILabel!
  @IBOutlet weak var checkConnectionLabel: UILabel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    let when = DispatchTime.now() + 7
    
    let notLaunchedBefore = UserDefaults.standard.value(forKey: "launchedBefore") as! Bool
    let lastRuns = UserDefaults.standard.value(forKey: "lastRun") as! Date
    let lastUpdate = UserDefaults.standard.value(forKey: "lastUpdate") as! Date
    
    //    lastUpdateLabel.text = "Ultimo Update: \(lastUpdate)"
    nowDateLabel.text = "Data Attuale: \(Date())"
    
    if notLaunchedBefore {
      // Primo avvio dell'App
      
      startLabel.text = "Avvio: Primo Avvio"
      lastStartLabel.text = "\(lastRuns)"
      passedDaysLabel.text = "0"
      needsUpdateLabel.text = "Si"
      lastUpdateLabel.text = "Mai"
      
      if CheckConnection.shared.isConnectedToNetwork() {
        //C'è connessione
        checkConnectionLabel.text = "Si"
        
        DispatchQueue.main.asyncAfter(deadline: when) {
          UserDefaults.standard.set(Date() , forKey: "lastUpdate")
          self.performSegue(withIdentifier: "updateDatabase", sender: nil)
        }
      } else {
        //NON c'è connessione
        checkConnectionLabel.text = "No"
        
        UserDefaults.standard.set(nil, forKey: "launchedBefore")
        lastUpdateLabel.text = "Mai"
        let alert = UIAlertController(title: "Internet Connection Reqiured", message: "To download important elements for the app you need an internet connection!", preferredStyle: UIAlertControllerStyle.alert)
        //        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
      }
    } else {
      //NON primo avvio
      
      startLabel.text = "Avvio: App avviata in precedenza"
      lastStartLabel.text = "\(lastRuns)"
      passedDaysLabel.text = "\(Date().interval(ofComponent: .second, fromDate: lastUpdate))"
      lastUpdateLabel.text = "\(lastUpdate)"
      
      
      if Date().interval(ofComponent: .second, fromDate: lastUpdate) > 37 {
        //Passati più di 13 giorni
        needsUpdateLabel.text = "Si"
        
        if CheckConnection.shared.isConnectedToNetwork() {
          //C'è la connessione
          checkConnectionLabel.text = "Si"
          
          DispatchQueue.main.asyncAfter(deadline: when) {
            UserDefaults.standard.set(Date() , forKey: "lastUpdate")
            self.performSegue(withIdentifier: "updateDatabase", sender: nil)
          }
        } else {
          checkConnectionLabel.text = "No"
          
          DispatchQueue.main.asyncAfter(deadline: when) {
            self.performSegue(withIdentifier: "afterStart", sender: nil)
          }
        }
      } else {
        //Non sono passsati più di 13 giorni
        needsUpdateLabel.text = "No"
        checkConnectionLabel.text = "Inutile verificare, non deve aggiornare"
        
        DispatchQueue.main.asyncAfter(deadline: when) {
          self.performSegue(withIdentifier: "afterStart", sender: nil)
        }
      }
    }
  }
}

extension Date {
  
  func interval(ofComponent comp: Calendar.Component, fromDate date: Date) -> Int {
    
    let currentCalendar = Calendar.current
    
    guard let start = currentCalendar.ordinality(of: comp, in: .era, for: date) else { return 0 }
    guard let end = currentCalendar.ordinality(of: comp, in: .era, for: self) else { return 0 }
    
    return end - start
  }
}


