//
//  BuzzerViewController.swift
//  CoreAnimation
//
//  Created by Claudio Renza on 13/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import UIKit

class BuzzerViewController: UIViewController {

  var questionView: UIView!
  var classicBuzzerView: UIView!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        print("LOAD")

        if let questionView = Bundle.main.loadNibNamed("QuestionView", owner: self, options: nil)?.first as? QuestionView {
          
          questionView.frame = CGRect(x: 10, y: 0, width: 300, height: 300)
          questionView.center = self.view.center
          self.view.addSubview(questionView)
          
          
        }
      
      
      
        if let classicBuzzerView = Bundle.main.loadNibNamed("ClassicBuzzerView", owner: self, options: nil)?.first as? ClassicBuzzerView {
          
          classicBuzzerView.frame = CGRect(x: 200, y: 0, width: 300, height: 300)
          classicBuzzerView.center = self.view.center
          self.view.addSubview(classicBuzzerView)
          
          
        }

      
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
