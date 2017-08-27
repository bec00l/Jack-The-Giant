//
//  AudioManager.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/27/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import AVFoundation

class AudioManager {
    static let instance = AudioManager()
    
    private init() {
        
    }
    
    private var audioPlayer : AVAudioPlayer?
    
    func playBGMusic() {
        let url = Bundle.main.url(forResource: "Background music", withExtension: "mp3")
        
        var error : Error?
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: url!)
            audioPlayer?.numberOfLoops = -1
            audioPlayer?.prepareToPlay()
            audioPlayer?.play()
        }
        catch let err1 as NSError {
            error = err1
        }
        
        if error != nil {
            print("There is an error \(error)")
        }
    }
    
    func stopBGMusic () {
        if audioPlayer?.isPlaying == true {
            audioPlayer?.stop()
        }
    }
    
    func isAudioPlayerInitialized() -> Bool {
        return audioPlayer == nil

    }
}
