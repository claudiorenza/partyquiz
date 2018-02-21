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
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    
        //self.pickedValueTextField.tintColor = .clear
        //self.pickedValueTextField.canPerformAction(self, withSender: nil)
    
        pickerData = ["5", "10", "15", "20", "25", "30"]
        createPicker()
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
  
  @objc func donePressed() {
    self.view.endEditing(true)
  }
  
}

extension UITextField {
  
  open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
    return false //action == #selector(UIResponderStandardEditActions.cut) || action == #selector(UIResponderStandardEditActions.copy)
  }
}
