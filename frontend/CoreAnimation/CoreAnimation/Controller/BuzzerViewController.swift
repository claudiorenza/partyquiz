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
          
          questionView.frame = CGRect(x: 20, y: 32, width: 256, height: 256)
          
          /*
          questionView.translatesAutoresizingMaskIntoConstraints = false
          questionView.addConstraint(NSLayoutConstraint(item: self.questionView,
                                                          attribute: NSLayoutAttribute.height,
                                                          relatedBy: NSLayoutRelation.equal,
                                                          toItem: self.questionView,
                                                          attribute: NSLayoutAttribute.width,
                                                          multiplier: self.questionView.frame.size.height / self.questionView.frame.size.width,
                                                          constant: 0))
          //questionView.center = self.view.center
 
          */
          self.view.addSubview(questionView)
          
          
        }
      /*
        if let answersView = Bundle.main.loadNibNamed("AnswersView", owner: self, options: nil)?.first as? AnswersView {
          
          answersView.frame = CGRect(x: 292, y:32, width: 256, height: 256)
          
          self.view.addSubview(answersView)
          
          
        }
      */
        if let classicBuzzerView = Bundle.main.loadNibNamed("ClassicBuzzerView", owner: self, options: nil)?.first as? ClassicBuzzerView {
          
          classicBuzzerView.frame = CGRect(x: 292, y:32, width: 256, height: 256)
          /*
          classicBuzzerView.translatesAutoresizingMaskIntoConstraints = false
          classicBuzzerView.addConstraint(NSLayoutConstraint(item: self.classicBuzzerView,
                                                        attribute: NSLayoutAttribute.height,
                                                        relatedBy: NSLayoutRelation.equal,
                                                        toItem: self.questionView,
                                                        attribute: NSLayoutAttribute.width,
                                                        multiplier: self.classicBuzzerView.frame.size.height / self.classicBuzzerView.frame.size.width,
                                                        constant: 0))
          //classicBuzzerView.center = self.view.center
           */
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
