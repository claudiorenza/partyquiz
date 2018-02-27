//
//  SettingsViewController.swift
//  Party Quiz Game
//
//  Created by Ernesto De Crecchio on 21/02/18.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
  
  let numberOfQuestionsPicker = UIPickerView()
  var pickerData: [String] = [String]()
  
  @IBOutlet weak var pickedValueTextField: UITextField!
  @IBOutlet weak var startGameButton: UIButton!
  @IBOutlet weak var labelOutlet: UILabel!
  
  var labelPosition = CGPoint()
  var textFieldPosition = CGPoint()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    PeerManager.peerShared.viewController = self
    
    labelOutlet.clipsToBounds = true
    labelOutlet.layer.cornerRadius = 15.0
    labelOutlet.layer.borderColor = UIColor.colorGray().cgColor
    labelOutlet.layer.borderWidth = 4.0
    
    startGameButton.layer.cornerRadius = 25.0
    startGameButton.layer.borderColor = UIColor.colorGray().cgColor
    startGameButton.layer.borderWidth = 6.0
    
    pickerData = ["5", "10", "15", "20", "25", "30"]
    createPicker()
  
    labelPosition = labelOutlet.center
    textFieldPosition = pickedValueTextField.center
  }
  
  override func viewWillAppear(_ animated: Bool) {
    startGameButton.center.x = -startGameButton.frame.width
    
    self.startGameButton.entering(view: self.view)
    self.startGameButton.center.x = self.view.frame.midX
  }
  
  
  func createPicker() {
    //toolbar
    let toolbar = UIToolbar()
    toolbar.sizeToFit()
    
    //done button for toolbar
    let done = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
    toolbar.setItems([done], animated: false)
    
    self.numberOfQuestionsPicker.delegate = self
    self.numberOfQuestionsPicker.dataSource = self
    
    pickedValueTextField.inputAccessoryView = toolbar
    pickedValueTextField.inputView = numberOfQuestionsPicker
  }
  
  @IBAction func startGamePressed(_ sender: Any) {
    startGameButton.exit(directionTo: "left", view: view, duration: 1.0)
    
    let selectedNumber = Int(pickedValueTextField.text!)
    
    print("Numero Selezionato: \(String(describing: selectedNumber))")
    
    convert(numberOfQuestions: selectedNumber!)
    print("Numero elementi nel dizionario: \(CoreDataManager.shared.questionDictionary.count)")
    
    for i in 0...CoreDataManager.shared.questionDictionary.count-1 {
      let question = CoreDataManager.shared.questionDictionary[i]
      print(question["text"]!)
    }
    
    PeerManager.peerShared.stopBrowser()
    PeerManager.peerShared.startAdvertiser()
    PeerManager.peerShared.setupBrowserVC()
    present(PeerManager.peerShared.browserVC, animated: true, completion: nil)
  }
  
  func convert(numberOfQuestions: Int) {
    let indexSelectedQuestions = generateRandomListNumbers(numberOfNumbers: numberOfQuestions)
    
    for i in 0...numberOfQuestions-1 {
      //      print("Inserisco nel dictionary la domanda: \(indexSelectedQuestions[i])")
      
      CoreDataManager.shared.questionDictionary.append([/*"id":CoreDataManager.shared.question[i].value(forKey: "id"),*/ "text":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "text") as! String, "correctlyAnswer":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "correctlyAnswer") as! String, "wrongAnswer1":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "wrongAnswer1") as! String, "wrongAnswer2":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "wrongAnswer2") as! String, "wrongAnswer3":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "wrongAnswer3") as! String, "category":CoreDataManager.shared.question[indexSelectedQuestions[i]].value(forKey: "category") as! String])
    }
    //    print("QuestionDictionary Popolato")
  }
  
  
  
  let entityNameQ = "Question"
  let context = CoreDataManager.shared.createContext()
  let entity = CoreDataManager.shared.createEntity(nameEntity: "Question")
  
  //Generate a random list of numbers
  func generateRandomListNumbers(numberOfNumbers: Int) -> [Int] {
    var randomNumbers = [Int]()
    var x:Int = 1
    var i:Int = 0
    var check:Bool = true
    
    print("Numero massimo: \(CoreDataManager.shared.countRow(nameEntity: entityNameQ, context: context))")
    randomNumbers.append(Int(arc4random_uniform(UInt32(CoreDataManager.shared.question.count))))
    //    print("Inserito \(randomNumbers[0]) in lista\n")
    
    repeat {
      randomNumbers.append(Int(arc4random_uniform(UInt32(CoreDataManager.shared.question.count))))
      //      print("Inserito \(randomNumbers[x]) in lista, controllo se va bene\n")
      i = 0
      check = true
      repeat {
        if (randomNumbers[i] != randomNumbers[x]) {
          //          print("--\(randomNumbers[i]) diverso da \(randomNumbers[x])\n")
          i = i+1
        } else {
          //          print("--\(randomNumbers[i]) uguale a \(randomNumbers[x])\n")
          check = false
        }
      } while (check && (i < x))
      
      if(check) {
        //        print("-Numero valido\n")
        x = x+1
      } else {
        //        print("-Numero NON valido\n")
        randomNumbers.removeLast()
      }
    } while (x < numberOfNumbers)
    
    //    print("LISTA:\n")
    //    for i in 0...numberOfNumbers-1 {
    //      print("- \(randomNumbers[i])")
    //    }
    
    return randomNumbers
  }
  
  
  ///////////////////////
  
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return pickerData.count
  }
  
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return pickerData[row]
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    pickedValueTextField.text = pickerData[row]
  }
  
  @IBAction func textFieldAction(_ sender: UITextField) {
    labelOutlet.moveUp(view: view)
    pickedValueTextField.moveUp(view: view)
    Singleton.shared.delayWithSeconds(0.3) {
      self.labelOutlet.center.y = self.view.bounds.height * 0.1
      self.pickedValueTextField.center.y = self.view.bounds.height * 0.3
    }
  }
  
  @objc func donePressed() {
    self.view.endEditing(true)
    labelOutlet.moveDown(view: view, point: labelPosition)
    pickedValueTextField.moveDown(view: view, point: textFieldPosition)
    Singleton.shared.delayWithSeconds(0.3) {
      self.labelOutlet.center.y = self.labelPosition.y
      self.pickedValueTextField.center.y = self.textFieldPosition.y
    }
  }
}

extension UITextField {
  
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false //action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
  }
}
