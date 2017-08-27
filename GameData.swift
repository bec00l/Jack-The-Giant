//
//  GameData.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/27/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import Foundation
class GameData : NSObject, NSCoding {
    
    struct Keys {
        static let EasyDifficultyScore = "EasyDifficultyScore"
        static let MediumDifficultyScore = "MediumDifficultyScore"
        static let HardDifficultyScore = "HardDifficultyScore"
        
        static let EasyDifficultyCoinScore = "EasyDifficultyCoinScore"
        static let MediumDifficultyCoinScore = "MediumDifficultyCoinScore"
        static let HardDifficultyCoinScore = "HardDifficultyCoinScore"
        
        static let EasyDifficulty = "EasyDifficulty"
        static let MediumDifficulty = "MediumDifficulty"
        static let HardDifficulty = "HardDifficulty"
        
        static let Music = "Music"
    }
    private var easyDifficulty = false
    private var mediumDifficulty = false
    private var hardDifficulty = false
    
    private var easyDifficultyCoinScore = Int32()
    private var mediumDifficultyCoinScore = Int32()
    private var hardDifficultyCoinScore = Int32()
    
    private var easyDifficultyScore = Int32()
    private var mediumDifficultyScore = Int32()
    private var hardDifficultyScore = Int32()
    
    private var isMusicOn = false
    
    override init() {}
    
    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.easyDifficulty = aDecoder.decodeBool(forKey: Keys.EasyDifficulty)
        self.mediumDifficulty = aDecoder.decodeBool(forKey: Keys.MediumDifficulty)
        self.hardDifficulty = aDecoder.decodeBool(forKey: Keys.HardDifficulty)
        
        self.easyDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyCoinScore)
        self.mediumDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyCoinScore)
        self.hardDifficultyCoinScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyCoinScore)
        
        self.easyDifficultyScore = aDecoder.decodeInt32(forKey: Keys.EasyDifficultyScore)
        self.mediumDifficultyScore = aDecoder.decodeInt32(forKey: Keys.MediumDifficultyScore)
        self.hardDifficultyScore = aDecoder.decodeInt32(forKey: Keys.HardDifficultyScore)
        
        self.isMusicOn = aDecoder.decodeBool(forKey: Keys.Music)
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.easyDifficultyScore, forKey: Keys.EasyDifficultyScore)
        aCoder.encode(self.easyDifficulty, forKey: Keys.EasyDifficulty)
        aCoder.encode(self.easyDifficultyCoinScore, forKey: Keys.EasyDifficultyCoinScore)
        
        aCoder.encode(self.mediumDifficultyScore, forKey: Keys.MediumDifficultyScore)
        aCoder.encode(self.mediumDifficulty, forKey: Keys.MediumDifficulty)
        aCoder.encode(self.mediumDifficultyCoinScore, forKey: Keys.MediumDifficultyCoinScore)
        
        aCoder.encode(self.hardDifficultyScore, forKey: Keys.HardDifficultyScore)
        aCoder.encode(self.hardDifficulty, forKey: Keys.HardDifficulty)
        aCoder.encode(self.hardDifficultyCoinScore, forKey: Keys.HardDifficultyCoinScore)
        
        aCoder.encode(self.isMusicOn, forKey: Keys.Music)
    }
    
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        self.easyDifficultyScore = easyDifficultyScore
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        self.mediumDifficultyScore = mediumDifficultyScore
    }
    
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        self.hardDifficultyScore = hardDifficultyScore
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        self.easyDifficultyCoinScore = easyDifficultyCoinScore
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        self.mediumDifficultyCoinScore = mediumDifficultyCoinScore
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        self.hardDifficultyCoinScore = hardDifficultyCoinScore
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.easyDifficultyScore
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.mediumDifficultyScore
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.hardDifficultyScore
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.easyDifficultyCoinScore
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.mediumDifficultyCoinScore
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.hardDifficultyCoinScore
    }
    
    func setEasyDifficulty(easyDifficulty: Bool) {
        self.easyDifficulty = easyDifficulty
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool) {
        self.mediumDifficulty = mediumDifficulty
    }
    
    func setHardDifficulty(hardDifficulty: Bool) {
        self.hardDifficulty = hardDifficulty
    }
    
    func getEasyDifficulty() -> Bool {
        return self.easyDifficulty
    }
    
    func getMediumDifficulty() -> Bool {
        return self.mediumDifficulty
    }
    
    func getHardDifficulty() -> Bool {
        return self.hardDifficulty
    }
    
    func setIsMusicOn(isMusicOn : Bool)  {
        self.isMusicOn = isMusicOn
    }
    
    func getIsMusicOn() -> Bool {
        return self.isMusicOn
    }


}


