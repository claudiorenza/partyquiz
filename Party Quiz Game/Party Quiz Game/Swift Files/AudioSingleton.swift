//
//  File.swift
//  Party Quiz Game
//
//  Created by Claudio Renza on 23/02/2018.
//  Copyright © 2018 Abusive Designers. All rights reserved.
//

import Foundation
import AVFoundation

class AudioSingleton  {
  static let shared = AudioSingleton()
  
  func setAudioShared()  {
    do {
      try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
      try AVAudioSession.sharedInstance().setActive(true)
    }
    catch{
      print(error)
    }
  }
  
  
}
