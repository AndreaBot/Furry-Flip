//
//  GameLogic.swift
//  Memory Game
//
//  Created by Andrea Bottino on 21/04/2023.
//

import UIKit

struct GameLogic {
    
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

    var guess1 = ""
    var guess2 = ""
    var firstButton: UIButton?
    
    mutating func generateRandomAnimal() -> String {
        
        let random = allNames.randomElement()!
        if let entry = allNames.firstIndex(where: {$0 == random}) {
            allNames.remove(at: entry)
        }
        return random
    }

    mutating func match(_ currentButton: UIButton, _ prevButton: UIButton) {
        
        guess1 = ""
        guess2 = ""
        firstButton = nil
        
        currentButton.alpha = 0
        prevButton.alpha = 0
    }
    
    mutating func reset(_ currentButton: UIButton, _ prevButton: UIButton) {
        
        UIView.transition(with: currentButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        currentButton.setImage(UIImage(named: "black"), for: .normal)
        currentButton.isEnabled = true
        
        UIView.transition(with: prevButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        prevButton.setImage(UIImage(named: "black"), for: .normal)
        prevButton.isEnabled = true

        guess1 = ""
        guess2 = ""
        //firstButton = nil
    }
    
    mutating func startAgain(_ buttonArray: [CustomButton]) {
        
        allNames.append(contentsOf: originalArray)
        for button in buttonArray {
            button.revealedAnimal = generateRandomAnimal()
            setBlack(buttonArray)
        }
        guess1 = ""
        guess2 = ""
        firstButton = nil
    }
    
    func setBlack(_ buttonArray: [CustomButton]) {
        
        for button in buttonArray {
            button.isEnabled = true
            button.setImage(button.startImage, for: .normal)
            button.alpha = 1
        }
    }
}
