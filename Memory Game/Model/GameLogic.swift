//
//  GameLogic.swift
//  Memory Game
//
//  Created by Andrea Bottino on 21/04/2023.
//

import UIKit

class GameLogic {
    
    let defaults = UserDefaults.standard
    
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
    var totalTime = 15
    var secondsPassed = 0
    
    func match(_ currentButton: UIButton, _ prevButton: UIButton) {
        
        buttonsLeft -= 2
        guess1 = ""
        guess2 = ""
        firstButton = nil
        
        currentButton.alpha = 0
        prevButton.alpha = 0
        PlayerStats.stats["Correct Matches"]! += 1

        if buttonsLeft == 0 && secondsPassed < totalTime {
            timer.invalidate()
            PlayerStats.stats["Games Won"]! += 1
            PlayerStats.stats["Total Games Played"]! += 1
            defaults.set(PlayerStats.stats, forKey: "playerStats")
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
        PlayerStats.stats["Errors"]! += 1
    }
    
    func startAgain(_ VC: UIViewController, _ buttonArray: [CustomButton], _ progressBar: UIProgressView) {
        
        VC.view.isUserInteractionEnabled = false
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
            self.startTimer(buttonArray, progressBar)
        }
        buttonsLeft = 12
        guess1 = ""
        guess2 = ""
        firstButton = nil
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
    
    func startTimer(_ buttonArray: [CustomButton], _ progressBar: UIProgressView) {
        
        self.secondsPassed = 0
        progressBar.progress = 1
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            
            if self.secondsPassed < self.totalTime {
                self.secondsPassed += 1
                let percentageProgress = Float(self.secondsPassed) / Float(self.totalTime)
                progressBar.progress = 1 - percentageProgress
                
            } else {
                
                for button in buttonArray {
                        UIView.transition(with: button, duration: 0.5, options: .transitionCrossDissolve, animations: {
                            button.alpha = 0
                        }, completion: nil)
                    }
                timer.invalidate()
                if self.buttonsLeft > 0 {
                    PlayerStats.stats["Games Lost"]! += 1
                    PlayerStats.stats["Total Games Played"]! += 1
                    self.defaults.set(PlayerStats.stats, forKey: "playerStats")
                }
            }
        }
    }
}
