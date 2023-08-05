//
//  GameLogic.swift
//  Memory Game
//
//  Created by Andrea Bottino on 21/04/2023.
//

import UIKit

protocol GameLogicDelegate {
    func endGameWon()
    func endGameLost()
}

class GameLogic {
    
    let defaults = UserDefaults.standard
    var delegate: GameLogicDelegate?
    
    var originalArray = [
        "bird", "bird",
        "dog", "dog",
        "duck", "duck",
        "sheep", "sheep",
        "racoon", "racoon",
        "squirrel", "squirrel"
    ]
    
    var allNames = [
        "bird", "bird",
        "dog", "dog",
        "duck", "duck",
        "sheep", "sheep",
        "racoon", "racoon",
        "squirrel", "squirrel"
    ]
    
    var buttonsLeft = 12
    var guess1 = ""
    var guess2 = ""
    var firstButton: UIButton?
    
    var timer = Timer()
    var totalTime = 15.0
    var timePassed = 0.0
    
    
    func match(_ currentButton: UIButton, _ prevButton: UIButton, _ quitButton: UIBarButtonItem, _ newGameButton: UIButton) {
        
        buttonsLeft -= 2
        guess1 = ""
        guess2 = ""
        firstButton = nil
        
        currentButton.alpha = 0
        prevButton.alpha = 0
        PlayerStats.overallStats["Correct Matches"]! += 1
        PlayerStats.currentGameStats["Correct Matches"]! += 1
        
        if buttonsLeft == 0 && timePassed < totalTime {
            quitButton.isEnabled = true
            newGameButton.isEnabled = true
            timer.invalidate()
            PlayerStats.overallStats["Games Won"]! += 1
            PlayerStats.overallStats["Total Games Played"]! += 1
            defaults.set(PlayerStats.overallStats, forKey: "playerStats")
            delegate?.endGameWon()
        }
    }
    
    func reset(_ currentButton: UIButton, _ prevButton: UIButton) {
        
        UIView.transition(with: currentButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        currentButton.setImage(UIImage(named: "black"), for: .normal)
        currentButton.isEnabled = true
        
        UIView.transition(with: prevButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        prevButton.setImage(UIImage(named: "black"), for: .normal)
        prevButton.isEnabled = true
        
        guess1 = ""
        guess2 = ""
        firstButton = nil
        PlayerStats.overallStats["Errors"]! += 1
        PlayerStats.currentGameStats["Errors"]! += 1
    }
    
    func startAgain(_ VC: UIViewController, _ buttonArray: [CustomButton], _ progressBar: UIProgressView, _ quitButton: UIBarButtonItem, _ newGameButton: UIButton) {
        
        VC.view.isUserInteractionEnabled = false
        quitButton.isEnabled = false
        newGameButton.isEnabled = false
        newGameButton.alpha = 0.4
        progressBar.progress = 0
        
        setBlack(buttonArray)
        for button in buttonArray {
            button.isEnabled = true
        }
        
        if allNames.count == 0 {
            allNames.append(contentsOf: originalArray)
        }
        
        for button in buttonArray {
            button.revealedAnimal = generateRandomAnimal()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            for button in buttonArray {
                UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromRight, animations: nil)
                button.setImage(UIImage(named: button.revealedAnimal), for: .normal)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            for button in buttonArray {
                UIView.transition(with: button, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
                button.setImage(UIImage(named: "black"), for: .normal)
            }
            VC.view.isUserInteractionEnabled = true
            self.startTimer(buttonArray, progressBar, quitButton, newGameButton)
        }
        buttonsLeft = 12
        guess1 = ""
        guess2 = ""
        firstButton = nil
        PlayerStats.currentGameStats["Cards Flipped"]! = 0
        PlayerStats.currentGameStats["Correct Matches"]! = 0
        PlayerStats.currentGameStats["Errors"]! = 0
    }
    
    func setBlack(_ buttonArray: [CustomButton]) {
        
        for button in buttonArray {
            if button.alpha == 0 {
                UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
            }
            button.isEnabled = false
            button.setImage(button.startImage, for: .normal)
            button.alpha = 1
        }
    }
    
    func generateRandomAnimal() -> String {
        
        let random = allNames.randomElement()!
        if let entry = allNames.firstIndex(where: {$0 == random}) {
            allNames.remove(at: entry)
        }
        return random
    }
    
    func startTimer(_ buttonArray: [CustomButton], _ progressBar: UIProgressView, _ quitButton: UIBarButtonItem, _ newGameButton: UIButton) {
        
        self.timePassed = 0.0
        progressBar.progress = 1
        progressBar.progressTintColor = .systemGreen
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.02, repeats: true) { [self] timer in
            
            if timePassed < totalTime {
                timePassed += 0.02
                let percentageProgress = Float(timePassed) / Float(totalTime)
                progressBar.progress = 1 - percentageProgress
                
                if (0.34...0.56).contains(progressBar.progress) {
                    progressBar.progressTintColor = .systemYellow
                } else if (0.20...0.38).contains(progressBar.progress) {
                    progressBar.progressTintColor = .systemOrange
                } else if (0.00...0.14).contains(progressBar.progress) {
                    progressBar.progressTintColor = .systemRed
                }
                
            } else {
                
                for button in buttonArray {
                    UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
                        button.alpha = 0
                    }, completion: nil)
                }
                timer.invalidate()
                if buttonsLeft > 0 {
                    quitButton.isEnabled = true
                    newGameButton.isEnabled = true
                    newGameButton.alpha = 1
                    PlayerStats.overallStats["Games Lost"]! += 1
                    PlayerStats.overallStats["Total Games Played"]! += 1
                    defaults.set(PlayerStats.overallStats, forKey: "playerStats")
                    delegate?.endGameLost()
                }
            }
        }
    }
}
