//
//  Buttons.swift
//  Memory Game
//
//  Created by Andrea Bottino on 21/04/2023.
//

import UIKit


struct Buttons {
    
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
    
    var img1: String?
    var img2: String?
    var img3: String?
    var img4: String?
    var img5: String?
    var img6: String?
    var img7: String?
    var img8: String?
    var img9: String?
    var img10: String?
    var img11: String?
    var img12: String?
    
    
    var guess1 = ""
    var guess2 = ""
    var firstButton: UIButton?
    
    mutating func assignToVar() -> String {
        
        let random = allNames.randomElement()!
        if let entry = allNames.firstIndex(where: {$0 == random}) {
            allNames.remove(at: entry)
        }
        return random
    }
    
    mutating func assignAll() {
        
        img1 = assignToVar()
        img2 = assignToVar()
        img3 = assignToVar()
        img4 = assignToVar()
        img5 = assignToVar()
        img6 = assignToVar()
        img7 = assignToVar()
        img8 = assignToVar()
        img9 = assignToVar()
        img10 = assignToVar()
        img11 = assignToVar()
        img12 = assignToVar()
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
        UIView.transition(with: prevButton, duration: 0.5, options: .transitionFlipFromLeft, animations: nil)
        
        guess1 = ""
        guess2 = ""
        firstButton = nil
        
        currentButton.setImage(UIImage(named: "black"), for: .normal)
        prevButton.setImage(UIImage(named: "black"), for: .normal)
        currentButton.isEnabled = true
        prevButton.isEnabled = true
        
    }
    
    mutating func startAgain(_ buttonArray: [UIButton]) {
        
        for button in buttonArray {
            button.isEnabled = true
            button.alpha = 1
            button.setImage(UIImage(named: "black"), for: .normal)
            guess1 = ""
            guess2 = ""
            firstButton = nil
        }
        allNames.append(contentsOf: originalArray)
    }
    
    func setBlack(_ buttonArray: [UIButton]) {
        for button in buttonArray {
            button.setImage(UIImage(named: "black"), for: .normal)
        }
    }
}
