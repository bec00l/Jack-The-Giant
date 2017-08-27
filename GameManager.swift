//
//  GameManager.swift
//  Jack the Giant
//
//  Created by David Hurd on 8/23/17.
//  Copyright © 2017 Imagitale Studios. All rights reserved.
//

import Foundation

class GameManager {
    static let instance = GameManager()
    private init() {}
    
    private var gameData : GameData?
    
    var gameStartedFromMainMenu = true
    var gameRestartedPlayerDied = false
    
    func initializeGameData () {
        if !FileManager.default.fileExists(atPath: getFilePath() as String) {
            gameData = GameData()
            gameData?.setEasyDifficultyScore(easyDifficultyScore: 0)
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0)
            
            gameData?.setMediumDifficultyScore(mediumDifficultyScore: 0)
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0)
            
            gameData?.setHardDifficultyScore(hardDifficultyScore: 0)
            gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: 0)
            
            gameData?.setMediumDifficulty(mediumDifficulty: true)
            gameData?.setEasyDifficulty(easyDifficulty: false)
            gameData?.setHardDifficulty(hardDifficulty: false)
            
            gameData?.setIsMusicOn(isMusicOn: false)
            
            saveData()
        }
        
        loadData()
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath() as String) as? GameData
    }
    
    func saveData () {
        if gameData != nil {
            NSKeyedArchiver.archiveRootObject(gameData!, toFile: getFilePath() as String)
        }
    }
    
    private func getFilePath() -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first as URL!
        return url!.appendingPathComponent("Game Manager").path
    }
    
    func setEasyDifficultyScore(easyDifficultyScore : Int32) {
        gameData?.setEasyDifficultyScore(easyDifficultyScore: easyDifficultyScore)
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return (self.gameData?.getEasyDifficultyScore())!
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore : Int32) {
        gameData?.setMediumDifficultyScore(mediumDifficultyScore: mediumDifficultyScore)
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return (self.gameData?.getMediumDifficultyScore())!
    }
    
    func setHardDifficultyScore(hardDifficultyScore : Int32) {
        gameData?.setHardDifficultyScore(hardDifficultyScore: hardDifficultyScore)
    }
    
    func getHardDifficultyScore() -> Int32 {
        return (self.gameData?.getHardDifficultyScore())!
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore : Int32) {
        gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyCoinScore)
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getEasyDifficultyCoinScore())!
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore : Int32) {
        gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumDifficultyCoinScore)
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getMediumDifficultyCoinScore())!
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore : Int32) {
        gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardDifficultyCoinScore)
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return (self.gameData?.getHardDifficultyCoinScore())!
    }
    
    func setEasyDifficulty(easyDifficulty: Bool) {
        gameData?.setEasyDifficulty(easyDifficulty: easyDifficulty)
    }
    
    func getEasyDifficulty() -> Bool {
        return (self.gameData?.getEasyDifficulty())!
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool) {
        gameData?.setMediumDifficulty(mediumDifficulty: mediumDifficulty)
    }
    
    func getMediumDifficulty() -> Bool {
        return (self.gameData?.getMediumDifficulty())!
    }
    
    func setHardDifficulty(hardDifficulty: Bool) {
        gameData?.setHardDifficulty(hardDifficulty: hardDifficulty)
    }
    
    func getHardDifficulty() -> Bool {
        return (self.gameData?.getHardDifficulty())!
    }
    
    func setIsMusicOn(isMusicOn: Bool) {
        gameData?.setIsMusicOn(isMusicOn: isMusicOn)
    }
    
    func getIsMusicOn() -> Bool {
        return (self.gameData?.getIsMusicOn())!
    }
}
