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
  
  var audioButtonClick = Audio(fileName: "buttonClick", typeName: "m4a")
  var audioMusic = Audio(fileName: "musicIntro", typeName: "m4a")
  
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
